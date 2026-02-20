import SwiftUI

struct WelcomeView: View {
    @EnvironmentObject var router: NavigationRouter
    
    var body: some View {
        VStack(spacing: 0) {
            Spacer()
            
            ZStack {
                Circle()
                    .fill(Color.warmCoral.opacity(0.1))
                    .frame(width: 180, height: 180)
                
                Image(systemName: "figure.walk.motion")
                    .font(.system(size: 88, weight: .light))
                    .foregroundColor(Color.deepOceanTeal)
                    .accessibilityHidden(true)
            }
            .padding(.bottom, 40)
            
            VStack(spacing: 20) {
                Text("GentleStep")
                    .font(.system(size: 42, weight: .heavy, design: .rounded))
                    .foregroundColor(Color.darkSlate)
                
                Text("Take a mindful moment for your mobility. Simple, clinically-inspired exercises designed to safely integrate into your daily routine.")
                    .font(.system(size: 20, weight: .regular, design: .rounded))
                    .foregroundColor(Color.darkSlate.opacity(0.85))
                    .multilineTextAlignment(.center)
                    .padding(.horizontal, 32)
                    .lineSpacing(6)
            }
            
            Spacer()
            
            if router.exercisesCompletedToday > 0 {
                HStack(spacing: 12) {
                    Image(systemName: "flame.fill")
                        .foregroundColor(Color.warmCoral)
                        .font(.title2)
                    Text("Today's Progress: \(router.exercisesCompletedToday) Exercises")
                        .font(.system(size: 18, weight: .semibold, design: .rounded))
                        .foregroundColor(Color.darkSlate)
                }
                .padding(.vertical, 16)
                .padding(.horizontal, 24)
                .glassCardStyle()
                .padding(.bottom, 32)
            }
            
            PrimaryButton(title: "Begin Journey", icon: "play.fill") {
                router.push(.selection)
            }
            .padding(.horizontal, 32)
            .padding(.bottom, 48)
        }
        .background(
            RadialGradient(colors: [Color.white, Color.warmAlabaster], center: .top, startRadius: 100, endRadius: 800)
                .ignoresSafeArea()
        )
    }
}

// FIXED: Playgrounds requires Environment Object injection in the Preview
#Preview {
    WelcomeView()
        .environmentObject(NavigationRouter())
}
