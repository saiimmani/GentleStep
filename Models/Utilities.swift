import SwiftUI

extension Color {
    static let warmAlabaster = Color(red: 0.976, green: 0.965, blue: 0.941)
    static let deepOceanTeal = Color(red: 0.0, green: 0.361, blue: 0.431)
    static let deepOceanTealLight = Color(red: 0.0, green: 0.461, blue: 0.531)
    static let warmCoral = Color(red: 0.816, green: 0.361, blue: 0.263) 
    static let darkSlate = Color(red: 0.110, green: 0.169, blue: 0.212)
    static let softSilver = Color(red: 0.898, green: 0.905, blue: 0.917)
}

enum AppRoute: Hashable {
    case selection
    case exercise(Exercise)
    case completion
}

@MainActor
final class NavigationRouter: ObservableObject {
    @Published var path: [AppRoute] = []
    
    var exercisesCompletedToday: Int {
        get { UserDefaults.standard.integer(forKey: "dailyCompletions") }
        set { 
            UserDefaults.standard.set(newValue, forKey: "dailyCompletions")
            objectWillChange.send()
        }
    }
    
    func push(_ route: AppRoute) {
        path.append(route)
    }
    
    func popToRoot() {
        path.removeAll()
    }
    
    func markExerciseComplete() {
        exercisesCompletedToday += 1
    }
}

struct GlassCardModifier: ViewModifier {
    func body(content: Content) -> some View {
        content
            .background(
                RoundedRectangle(cornerRadius: 24, style: .continuous)
                    .fill(.regularMaterial)
                    .overlay(
                        RoundedRectangle(cornerRadius: 24, style: .continuous)
                            .stroke(Color.white.opacity(0.6), lineWidth: 1)
                    )
            )
            .shadow(color: Color.darkSlate.opacity(0.06), radius: 16, x: 0, y: 8)
    }
}

extension View {
    func glassCardStyle() -> some View {
        self.modifier(GlassCardModifier())
    }
}
