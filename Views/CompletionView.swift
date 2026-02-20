import SwiftUI

struct CompletionView: View {
    @EnvironmentObject var router: NavigationRouter
    @State private var isVisible: Bool = false
    
    var body: some View {
        VStack(spacing: 36) {
            Spacer()
            
            ZStack {
                Circle()
                    .fill(
                        RadialGradient(colors: [Color.warmCoral.opacity(0.4), .clear], center: .center, startRadius: 10, endRadius: 150)
                    )
                    .frame(width: 300, height: 300)
                    .scaleEffect(isVisible ? 1.0 : 0.1)
                    .opacity(isVisible ? 1.0 : 0.0)
                
                // FIXED: Replaced .foregroundStyle with .foregroundColor to prevent ShapeStyle compiler errors
                Image(systemName: "checkmark.seal.fill")
                    .font(.system(size: 110))
                    .foregroundColor(Color.warmCoral)
                    .scaleEffect(isVisible ? 1.0 : 0.01)
                    .rotationEffect(.degrees(isVisible ? 0 : -90))
                    .opacity(isVisible ? 1.0 : 0.0)
            }
            
            VStack(spacing: 16) {
                Text("Brilliant!")
                    .font(.system(size: 40, weight: .heavy, design: .rounded))
                    .foregroundColor(Color.darkSlate)
                    .opacity(isVisible ? 1.0 : 0.0)
                    .offset(y: isVisible ? 0 : 20)
                
                Text("You've completed \(router.exercisesCompletedToday) exercise\(router.exercisesCompletedToday == 1 ? "" : "s") today.\nConsistency is the key to mobility.")
                    .font(.system(size: 20, weight: .medium, design: .rounded))
                    .foregroundColor(Color.darkSlate.opacity(0.85))
                    .multilineTextAlignment(.center)
                    .padding(.horizontal, 36)
                    .lineSpacing(6)
                    .opacity(isVisible ? 1.0 : 0.0)
                    .offset(y: isVisible ? 0 : 20)
            }
            
            Spacer()
            
            PrimaryButton(title: "Finish", icon: "house.fill") {
                router.popToRoot()
            }
            .padding(.horizontal, 32)
            .padding(.bottom, 48)
            .opacity(isVisible ? 1.0 : 0.0)
        }
        .background(
            Color.warmAlabaster.ignoresSafeArea()
        )
        .navigationBarBackButtonHidden(true)
        .onAppear {
            withAnimation(.spring(response: 0.6, dampingFraction: 0.7)) {
                isVisible = true
            }
        }
    }
}

// FIXED: Playgrounds requires Environment Object injection in the Preview
#Preview {
    CompletionView()
        .environmentObject(NavigationRouter())
}
