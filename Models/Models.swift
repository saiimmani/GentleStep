import Foundation

enum ExerciseType: String, CaseIterable, Identifiable, Hashable {
    case ankleCircles = "Ankle Circles"
    case heelRaises = "Heel Raises"
    case toeFlex = "Toe Flex & Point"
    case seatedStretch = "Seated Calf Stretch"
    
    var id: String { self.rawValue }
}

struct InstructionStep: Identifiable, Equatable, Hashable {
    let id = UUID()
    let icon: String
    let instruction: String
}

struct Exercise: Identifiable, Equatable, Hashable {
    let id = UUID()
    let type: ExerciseType
    let description: String
    let duration: TimeInterval
    let steps: [InstructionStep]
    
    static let all: [Exercise] = [
        Exercise(
            type: .ankleCircles,
            description: "Gently roll your ankle in a smooth, continuous circle. This lubricates the joint and reduces morning stiffness.",
            duration: 30.0,
            steps: [
                InstructionStep(icon: "arrow.up.right.circle", instruction: "Lift your foot slightly off the floor."),
                InstructionStep(icon: "arrow.triangle.2.circlepath", instruction: "Slowly draw a large circle with your big toe."),
                InstructionStep(icon: "clock.arrow.2.circlepath", instruction: "Keep the movement smooth and continuous.")
            ]
        ),
        Exercise(
            type: .heelRaises,
            description: "Keep your toes planted and lift your heel off the ground. Excellent for calf strength and Achilles flexibility.",
            duration: 30.0,
            steps: [
                InstructionStep(icon: "shoeprints.fill", instruction: "Plant both feet flat on the ground."),
                InstructionStep(icon: "arrow.up", instruction: "Push down through your toes to lift your heel."),
                InstructionStep(icon: "arrow.down", instruction: "Slowly lower your heel back to the starting position.")
            ]
        ),
        Exercise(
            type: .toeFlex,
            description: "Point your toes forward, then flex them back towards you. Helps relieve plantar tension.",
            duration: 30.0,
            steps: [
                InstructionStep(icon: "arrow.right", instruction: "Point your toes forward as far as comfortable."),
                InstructionStep(icon: "pause.circle", instruction: "Hold the pointed position for one second."),
                InstructionStep(icon: "arrow.left", instruction: "Flex your toes back towards your shin and hold.")
            ]
        ),
        Exercise(
            type: .seatedStretch,
            description: "Extend your leg and gently pull your toes back to stretch the calf muscle deeply.",
            duration: 45.0,
            steps: [
                InstructionStep(icon: "figure.flexibility", instruction: "Sit comfortably and extend one leg straight out."),
                InstructionStep(icon: "hand.point.left.fill", instruction: "Flex your toes back towards your body."),
                InstructionStep(icon: "timer", instruction: "Hold the stretch steadily without bouncing.")
            ]
        )
    ]
}
