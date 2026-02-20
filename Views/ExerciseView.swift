import SwiftUI

struct ExerciseView: View {
    let exercise: Exercise
    @StateObject private var viewModel: ExerciseViewModel
    @EnvironmentObject var router: NavigationRouter
    
    init(exercise: Exercise) {
        self.exercise = exercise
        _viewModel = StateObject(wrappedValue: ExerciseViewModel(duration: exercise.duration))
    }
    
    var body: some View {
        VStack(spacing: 0) {
            ZStack {
                Circle()
                    .fill(Color.white)
                    .frame(width: 260, height: 260)
                    .shadow(color: .black.opacity(0.03), radius: 20, x: 0, y: 10)
                
                ProgressRing(progress: viewModel.progress, strokeWidth: 16)
                    .frame(width: 290, height: 290)
                
                AbstractRhythmVisualizer(type: exercise.type, isRunning: viewModel.isRunning)
                    .frame(width: 160, height: 160)
            }
            .padding(.vertical, 40)
            
            StepCarousel(steps: exercise.steps)
                .frame(height: 120)
                .padding(.bottom, 24)
            
            Spacer()
            
            VStack(spacing: 24) {
                Text(timeString(from: viewModel.progress))
                    .font(.system(size: 42, weight: .semibold, design: .monospaced))
                    .foregroundColor(Color.deepOceanTeal)
                
                PrimaryButton(
                    title: viewModel.isRunning ? "Pause" : (viewModel.progress > 0 ? "Resume" : "Start Exercise"),
                    icon: viewModel.isRunning ? "pause.fill" : "play.fill"
                ) {
                    withAnimation {
                        viewModel.toggleTimer()
                    }
                }
                .padding(.horizontal, 32)
                .padding(.bottom, 48)
            }
        }
        .background(Color.warmAlabaster.ignoresSafeArea())
        .navigationTitle(exercise.type.rawValue)
        .navigationBarTitleDisplayMode(.inline)
        .onDisappear {
            viewModel.stopTimer()
        }
        .onChange(of: viewModel.isFinished) { oldValue, finished in
            if finished {
                router.markExerciseComplete()
                router.push(.completion)
            }
        }
    }
    
    private func timeString(from progress: Double) -> String {
        let remaining = max(0, exercise.duration - (progress * exercise.duration))
        return String(format: "00:%02d", Int(ceil(remaining)))
    }
}

// FIXED: Playgrounds requires Environment Object injection in the Preview
#Preview {
    ExerciseView(exercise: Exercise.all[0])
        .environmentObject(NavigationRouter())
}
