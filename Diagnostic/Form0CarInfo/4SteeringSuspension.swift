import SwiftUI
import UIKit
// Steering Components - Page 26
struct diagnosticView26: View {
    var body: some View {
        DiagnosticPage(
            category: .steeringSuspension,
            sectionTitle: "Steering Components",
            logKey: "SteeringComponents",
            logLabel: "SteeringComponents",
            photoKey: "page26",
            photoButtonTitle: "Take Photo for Page 26",
            next: diagnosticView27(),
            previous: diagnosticView25()
        )
    }
}

// Suspension Components - Page 27
struct diagnosticView27: View {
    var body: some View {
        DiagnosticPage(
            category: .steeringSuspension,
            sectionTitle: "Suspension Components",
            logKey: "SuspensionComponents",
            logLabel: "SuspensionComponents",
            photoKey: "page27",
            photoButtonTitle: "Take Photo for Page 27",
            next: diagnosticView28(),
            previous: diagnosticView26()
        )
    }
}
// Shocks/Struts - Page 28
struct diagnosticView28: View {
    var body: some View {
        DiagnosticPage(
            category: .steeringSuspension,
            sectionTitle: "Shocks/Struts",
            logKey: "ShocksStruts",
            logLabel: "ShocksStruts",
            photoKey: "page28",
            photoButtonTitle: "Take Photo for Page 28",
            next: diagnosticView29(),
            previous: diagnosticView27()
        )
    }
}

// Ball Joints - Page 29
struct diagnosticView29: View {
    var body: some View {
        DiagnosticPage(
            category: .steeringSuspension,
            sectionTitle: "Ball Joints",
            logKey: "BallJoints",
            logLabel: "BallJoints",
            photoKey: "page29",
            photoButtonTitle: "Take Photo for Page 29",
            next: diagnosticView30(),
            previous: diagnosticView28()
        )
    }
}

// Tie Rod Ends - Page 30
struct diagnosticView30: View {
    var body: some View {
        DiagnosticPage(
            category: .steeringSuspension,
            sectionTitle: "Tie Rod Ends",
            logKey: "TieRodEnds",
            logLabel: "TieRodEnds",
            photoKey: "page30",
            photoButtonTitle: "Take Photo for Page 30",
            next: diagnosticView31(),
            previous: diagnosticView29()
        )
    }
}

// Control Arms - Page 31
struct diagnosticView31: View {
    var body: some View {
        DiagnosticPage(
            category: .steeringSuspension,
            sectionTitle: "Control Arms",
            logKey: "ControlArms",
            logLabel: "ControlArms",
            photoKey: "page31",
            photoButtonTitle: "Take Photo for Page 31",
            next: diagnosticView32(),
            previous: diagnosticView30()
        )
    }
}

// Bushings - Page 32
struct diagnosticView32: View {
    var body: some View {
        DiagnosticPage(
            category: .steeringSuspension,
            sectionTitle: "Bushings",
            logKey: "Bushings",
            logLabel: "Bushings",
            photoKey: "page32",
            photoButtonTitle: "Take Photo for Page 32",
            next: diagnosticView33(),
            previous: diagnosticView31()
        )
    }
}

// Sway Bar Links - Page 33
struct diagnosticView33: View {
    var body: some View {
        DiagnosticPage(
            category: .steeringSuspension,
            sectionTitle: "Sway Bar Links",
            logKey: "SwayBarLinks",
            logLabel: "SwayBarLinks",
            photoKey: "page33",
            photoButtonTitle: "Take Photo for Page 33",
            next: diagnosticView34(),
            previous: diagnosticView32()
        )
    }
}

// Wheel Bearings - Page 34
struct diagnosticView34: View {
    var body: some View {
        DiagnosticPage(
            category: .steeringSuspension,
            sectionTitle: "Wheel Bearings",
            logKey: "WheelBearings",
            logLabel: "WheelBearings",
            photoKey: "page34",
            photoButtonTitle: "Take Photo for Page 34",
            next: diagnosticView35(),
            previous: diagnosticView33()
        )
    }
}

// CV Joints/Boots - Page 35
struct diagnosticView35: View {
    var body: some View {
        DiagnosticPage(
            category: .steeringSuspension,
            sectionTitle: "CV Joints/Boots",
            logKey: "CVJointsBoots",
            logLabel: "CVJointsBoots",
            photoKey: "page35",
            photoButtonTitle: "Take Photo for Page 35",
            next: diagnosticView36(),
            previous: diagnosticView34()
        )
    }
}

// Rack and pinion - Page 36
struct diagnosticView36: View {
    var body: some View {
        DiagnosticPage(
            category: .steeringSuspension,
            sectionTitle: "Rack and Pinion",
            logKey: "RackAndPinion",
            logLabel: "RackAndPinion",
            photoKey: "page36",
            photoButtonTitle: "Take Photo for Page 36",
            next: diagnosticView37(),
            previous: diagnosticView35()
        )
    }
}

// Power Steering Pump - Page 37
struct diagnosticView37: View {
    var body: some View {
        DiagnosticPage(
            category: .steeringSuspension,
            sectionTitle: "Power Steering Pump",
            logKey: "PowerSteeringPump",
            logLabel: "PowerSteeringPump",
            photoKey: "page37",
            photoButtonTitle: "Take Photo for Page 37",
            next: PrintSummaryView(),
            previous: diagnosticView36()
        )
    }
}


