import SwiftUI

@MainActor
final class ExerciseViewModel: ObservableObject {
    @Published private(set) var progress: Double = 0.0
    @Published private(set) var isRunning: Bool = false
    @Published private(set) var isFinished: Bool = false
    
    // FIXED: Switched to Task to comply with Swift 6 Strict Concurrency
    private var timerTask: Task<Void, Never>?
    let duration: TimeInterval
    
    init(duration: TimeInterval) {
        self.duration = duration
    }
    
    func toggleTimer() {
        if isRunning {
            stopTimer()
        } else {
            startTimer()
        }
    }
    
    private func startTimer() {
        guard !isRunning else { return }
        isRunning = true
        isFinished = false
        
        let startTime = Date().addingTimeInterval(-(progress * duration))
        
        // Swift 6 safe async loop (replaces Timer)
        timerTask = Task { @MainActor in
            while !Task.isCancelled {
                let elapsed = Date().timeIntervalSince(startTime)
                let currentProgress = min(elapsed / self.duration, 1.0)
                
                self.progress = currentProgress
                
                if currentProgress >= 1.0 {
                    self.isFinished = true
                    self.isRunning = false
                    break
                }
                
                // 50,000,000 nanoseconds = 0.05 seconds
                try? await Task.sleep(nanoseconds: 50_000_000)
            }
        }
    }
    
    func stopTimer() {
        timerTask?.cancel()
        timerTask = nil
        isRunning = false
    }
    
    deinit {
        timerTask?.cancel()
    }
}
