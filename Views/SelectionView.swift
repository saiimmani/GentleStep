import SwiftUI

struct SelectionView: View {
    @EnvironmentObject var router: NavigationRouter
    
    var body: some View {
        ScrollView(showsIndicators: false) {
            VStack(spacing: 24) {
                HStack {
                    Text("Choose an exercise based on your comfort level today.")
                        .font(.system(size: 18, weight: .medium, design: .rounded))
                        .foregroundColor(Color.darkSlate.opacity(0.7))
                    Spacer()
                }
                .padding(.horizontal, 28)
                .padding(.top, 8)
                .padding(.bottom, 8)
                
                ForEach(Exercise.all) { exercise in
                    ExerciseSelectionCard(exercise: exercise) {
                        router.push(.exercise(exercise))
                    }
                    .padding(.horizontal, 24)
                }
            }
            .padding(.bottom, 48)
        }
        .background(Color.warmAlabaster.ignoresSafeArea())
        .navigationTitle("Select Routine")
        .navigationBarTitleDisplayMode(.large)
    }
}

struct ExerciseSelectionCard: View {
    let exercise: Exercise
    let action: () -> Void
    
    var body: some View {
        Button(action: action) {
            HStack(spacing: 20) {
                ZStack {
                    // FIXED: Explicitly maps to UnitPoint.topLeading and UnitPoint.bottomTrailing
                    Circle()
                        .fill(LinearGradient(colors: [Color.warmCoral.opacity(0.2), Color.warmCoral.opacity(0.05)], startPoint: UnitPoint.topLeading, endPoint: UnitPoint.bottomTrailing))
                        .frame(width: 72, height: 72)
                    
                    Image(systemName: iconFor(exercise.type))
                        .font(.system(size: 28, weight: .medium))
                        .foregroundColor(Color.warmCoral)
                }
                
                VStack(alignment: .leading, spacing: 8) {
                    Text(exercise.type.rawValue)
                        .font(.system(size: 22, weight: .bold, design: .rounded))
                        .foregroundColor(Color.darkSlate)
                    
                    HStack(spacing: 6) {
                        Image(systemName: "clock")
                        Text("\(Int(exercise.duration)) Seconds")
                    }
                    .font(.system(size: 15, weight: .bold, design: .rounded))
                    .foregroundColor(Color.deepOceanTeal)
                    .padding(.horizontal, 10)
                    .padding(.vertical, 4)
                    .background(Color.deepOceanTeal.opacity(0.1))
                    .clipShape(Capsule())
                }
                
                Spacer()
                
                Image(systemName: "chevron.right.circle.fill")
                    .font(.system(size: 28))
                    .foregroundColor(Color.softSilver)
            }
            .padding(20)
            .glassCardStyle()
        }
        .buttonStyle(.plain)
    }
    
    private func iconFor(_ type: ExerciseType) -> String {
        switch type {
        case .ankleCircles: return "arrow.triangle.2.circlepath"
        case .heelRaises: return "arrow.up.and.down"
        case .toeFlex: return "arrow.left.and.right"
        case .seatedStretch: return "figure.flexibility"
        }
    }
}

// FIXED: Playgrounds requires Environment Object injection in the Preview
#Preview {
    SelectionView()
        .environmentObject(NavigationRouter())
}
