import SwiftUI
import UIKit
// Steering Components - Page 26
struct diagnosticView26: View {
    var body: some View {
        DiagnosticPage(
            category: .steeringSuspension,
            sectionTitle: "Steering Components",
            logKey: "Steering Components",
            logLabel: "Steering Components",
            photoKey: "page26",
            photoButtonTitle: "Take Photo for Steering Components",
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
            logKey: "Suspension Components",
            logLabel: "Suspension Components",
            photoKey: "page27",
            photoButtonTitle: "Take Photo for Suspension Components",
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
            logKey: "Shocks/Struts",
            logLabel: "Shocks/Struts",
            photoKey: "page28",
            photoButtonTitle: "Take Photo for Shocks/Struts",
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
            logKey: "Ball Joints",
            logLabel: "Ball Joints",
            photoKey: "page29",
            photoButtonTitle: "Take Photo for Ball Joints",
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
            logKey: "Tie Rod Ends",
            logLabel: "Tie Rod Ends",
            photoKey: "page30",
            photoButtonTitle: "Take Photo for Tie Rod Ends",
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
            logKey: "Control Arms",
            logLabel: "Control Arms",
            photoKey: "page31",
            photoButtonTitle: "Take Photo for Control Arms",
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
            photoButtonTitle: "Take Photo for Bushings",
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
            logKey: "Sway Bar Links",
            logLabel: "Sway Bar Links",
            photoKey: "page33",
            photoButtonTitle: "Take Photo for Sway Bar Links",
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
            logKey: "Wheel Bearings",
            logLabel: "Wheel Bearings",
            photoKey: "page34",
            photoButtonTitle: "Take Photo for Wheel Bearings",
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
            logKey: "CV Joints/Boots",
            logLabel: "CV Joints/Boots",
            photoKey: "page35",
            photoButtonTitle: "CV Joints/Boots",
            next: diagnosticView36(),
            previous: diagnosticView34()
        )
    }
}

// Rack & Pinion - Page 36
struct diagnosticView36: View {
    var body: some View {
        DiagnosticPage(
            category: .steeringSuspension,
            sectionTitle: "Rack & Pinion",
            logKey: "Rack & Pinion",
            logLabel: "Rack & Pinion",
            photoKey: "page36",
            photoButtonTitle: "Take Photo for Rack & Pinion",
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
            logKey: "Power Steering Pump",
            logLabel: "Power Steering Pump",
            photoKey: "page37",
            photoButtonTitle: "Take Photo for Power Steering Pump",
            next: PrintSummaryView(),
            previous: diagnosticView36()
        )
    }
}


