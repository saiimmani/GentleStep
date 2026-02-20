import SwiftUI

struct PrimaryButton: View {
    let title: String
    let icon: String?
    let action: () -> Void
    @State private var isPressed = false
    
    init(title: String, icon: String? = nil, action: @escaping () -> Void) {
        self.title = title
        self.icon = icon
        self.action = action
    }
    
    var body: some View {
        Button(action: action) {
            HStack(spacing: 12) {
                if let icon = icon {
                    Image(systemName: icon)
                        .font(.system(size: 20, weight: .bold))
                }
                Text(title)
                    .font(.system(size: 22, weight: .semibold, design: .rounded))
            }
            .foregroundColor(.white)
            .padding(.vertical, 20)
            .padding(.horizontal, 36)
            .frame(maxWidth: .infinity)
            .background(
                LinearGradient(colors: [Color.deepOceanTealLight, Color.deepOceanTeal], startPoint: UnitPoint.topLeading, endPoint: UnitPoint.bottomTrailing)
            )
            .clipShape(RoundedRectangle(cornerRadius: 20, style: .continuous))
            .shadow(color: Color.deepOceanTeal.opacity(0.3), radius: isPressed ? 4 : 12, x: 0, y: isPressed ? 2 : 6)
            .scaleEffect(isPressed ? 0.96 : 1.0)
            .animation(.spring(response: 0.3, dampingFraction: 0.6), value: isPressed)
        }
        .buttonStyle(PressDetectingButtonStyle(isPressed: $isPressed))
        .accessibilityAddTraits(.isButton)
    }
}

struct PressDetectingButtonStyle: ButtonStyle {
    @Binding var isPressed: Bool
    func makeBody(configuration: Configuration) -> some View {
        configuration.label
            .onChange(of: configuration.isPressed) { oldValue, newValue in
                isPressed = newValue
            }
    }
}

struct ProgressRing: View {
    var progress: Double
    var strokeWidth: CGFloat = 20
    
    var body: some View {
        ZStack {
            Circle()
                .stroke(Color.softSilver.opacity(0.5), style: StrokeStyle(lineWidth: strokeWidth, lineCap: .round))
            
            Circle()
                .trim(from: 0, to: CGFloat(progress))
                .stroke(
                    AngularGradient(
                        gradient: Gradient(colors: [Color.warmCoral, Color.warmCoral.opacity(0.8), Color.warmCoral]),
                        center: .center,
                        startAngle: .degrees(-90),
                        endAngle: .degrees(270)
                    ),
                    style: StrokeStyle(lineWidth: strokeWidth, lineCap: .round)
                )
                .rotationEffect(.degrees(-90))
                .shadow(color: Color.warmCoral.opacity(0.4), radius: 8, x: 0, y: 0)
                .animation(.linear(duration: 0.05), value: progress)
        }
        .accessibilityValue("\(Int(progress * 100)) percent complete")
    }
}

struct StepCarousel: View {
    let steps: [InstructionStep]
    
    var body: some View {
        ScrollView(.horizontal, showsIndicators: false) {
            HStack(spacing: 16) {
                ForEach(Array(steps.enumerated()), id: \.element.id) { index, step in
                    HStack(spacing: 16) {
                        ZStack {
                            Circle()
                                .fill(Color.deepOceanTeal.opacity(0.1))
                                .frame(width: 56, height: 56)
                            
                            Image(systemName: step.icon)
                                .font(.system(size: 24, weight: .semibold))
                                .foregroundColor(Color.deepOceanTeal)
                        }
                        
                        VStack(alignment: .leading, spacing: 4) {
                            Text("Step \(index + 1)")
                                .font(.system(size: 14, weight: .bold, design: .rounded))
                                .foregroundColor(Color.warmCoral)
                                .textCase(.uppercase)
                            
                            Text(step.instruction)
                                .font(.system(size: 17, weight: .medium, design: .rounded))
                                .foregroundColor(Color.darkSlate)
                                .fixedSize(horizontal: false, vertical: true)
                                .lineLimit(3)
                        }
                        Spacer(minLength: 0)
                    }
                    .padding(20)
                    .frame(width: 320, height: 110)
                    .glassCardStyle()
                }
            }
            .padding(.horizontal, 24)
        }
    }
}

struct AbstractRhythmVisualizer: View {
    let type: ExerciseType
    let isRunning: Bool
    
    @State private var phase: Bool = false
    
    var body: some View {
        ZStack {
            switch type {
            case .ankleCircles:
                ZStack {
                    Circle()
                        .strokeBorder(style: StrokeStyle(lineWidth: 2, dash: [8, 8]))
                        .foregroundColor(Color.deepOceanTeal.opacity(0.3))
                        .frame(width: 140, height: 140)
                    
                    Circle()
                        .fill(Color.warmCoral)
                        .frame(width: 24, height: 24)
                        .shadow(color: Color.warmCoral.opacity(0.6), radius: 10)
                        .offset(y: -70)
                        .rotationEffect(.degrees(isRunning ? 360 : 0))
                        .animation(isRunning ? .linear(duration: 3.5).repeatForever(autoreverses: false) : .default, value: isRunning)
                }
                
            case .heelRaises:
                ZStack {
                    Capsule()
                        .fill(Color.deepOceanTeal.opacity(0.1))
                        .frame(width: 12, height: 140)
                    
                    Capsule()
                        .fill(Color.deepOceanTeal)
                        .frame(width: 32, height: 32)
                        .shadow(color: Color.deepOceanTeal.opacity(0.4), radius: 8)
                        .offset(y: phase ? -55 : 55)
                        .animation(isRunning ? .easeInOut(duration: 1.5).repeatForever(autoreverses: true) : .default, value: phase)
                }
                
            case .toeFlex:
                ZStack {
                    Capsule()
                        .stroke(Color.deepOceanTeal.opacity(0.3), style: StrokeStyle(lineWidth: 2, dash: [6, 6]))
                        .frame(width: 140, height: 2)
                    
                    Capsule()
                        .fill(LinearGradient(colors: [Color.warmCoral, Color.warmCoral.opacity(0.8)], startPoint: UnitPoint.leading, endPoint: UnitPoint.trailing))
                        .frame(width: phase ? 140 : 36, height: phase ? 8 : 24)
                        .shadow(color: Color.warmCoral.opacity(0.5), radius: phase ? 10 : 4)
                        .animation(isRunning ? .easeInOut(duration: 1.5).repeatForever(autoreverses: true) : .default, value: phase)
                    
                    Circle()
                        .fill(Color.deepOceanTeal)
                        .frame(width: 16, height: 16)
                        .offset(x: phase ? -70 : -18)
                        .animation(isRunning ? .easeInOut(duration: 1.5).repeatForever(autoreverses: true) : .default, value: phase)
                    
                    Circle()
                        .fill(Color.deepOceanTeal)
                        .frame(width: 16, height: 16)
                        .offset(x: phase ? 70 : 18)
                        .animation(isRunning ? .easeInOut(duration: 1.5).repeatForever(autoreverses: true) : .default, value: phase)
                }
                
            case .seatedStretch:
                ZStack {
                    Image(systemName: "figure.flexibility")
                        .font(.system(size: 40))
                        .foregroundColor(Color.deepOceanTeal)
                    
                    Circle()
                        .stroke(Color.deepOceanTeal.opacity(0.5), lineWidth: 4)
                        .frame(width: 80, height: 80)
                        .scaleEffect(phase ? 2.2 : 1.0)
                        .opacity(phase ? 0.0 : 1.0)
                        .animation(isRunning ? .easeOut(duration: 3.0).repeatForever(autoreverses: false) : .default, value: phase)
                    
                    Circle()
                        .stroke(Color.deepOceanTeal.opacity(0.5), lineWidth: 4)
                        .frame(width: 80, height: 80)
                        .scaleEffect(phase ? 1.6 : 1.0)
                        .opacity(phase ? 0.0 : 1.0)
                        .animation(isRunning ? .easeOut(duration: 3.0).repeatForever(autoreverses: false).delay(1.0) : .default, value: phase)
                }
            }
        }
        .onChange(of: isRunning) { oldValue, running in
            if running {
                phase.toggle()
            } else {
                phase = false
            }
        }
    }
}
