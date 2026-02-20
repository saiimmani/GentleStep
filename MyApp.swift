import SwiftUI

@main
struct GentleStepApp: App {
    @StateObject private var router = NavigationRouter()
    
    var body: some Scene {
        WindowGroup {
            NavigationStack(path: $router.path) {
                WelcomeView()
                    .navigationDestination(for: AppRoute.self) { route in
                        switch route {
                        case .selection:
                            SelectionView()
                        case .exercise(let exercise):
                            ExerciseView(exercise: exercise)
                        case .completion:
                            CompletionView()
                        }
                    }
            }
            .environmentObject(router)
            .tint(Color.deepOceanTeal)
            .preferredColorScheme(.light)
        }
    }
}
