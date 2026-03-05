import SwiftUI
import UIKit

// Under Hood Overview - Page 1
struct diagnosticView1: View {
    var body: some View {
        DiagnosticPage(
            category: .underHood,
            sectionTitle: "Under Hood Overview",
            logKey: "Under Hood Overview",
            logLabel: "Under Hood Overview",
            photoKey: "page1",
            photoButtonTitle: "Take Photo for Under Hood Overview",
            next: AnyView(diagnosticView2()),
            previous: AnyView(EmptyView())
        )
    }
}

// Wiper Blades - Page 2
struct diagnosticView2: View {
    var body: some View {
        DiagnosticPage(
            category: .underHood,
            sectionTitle: "Wiper Blades",
            logKey: "Wiper Blades",
            logLabel: "Wiper Blades",
            photoKey: "page2",
            photoButtonTitle: "Take Photo for Wiper Blades",
            next: AnyView(diagnosticView3()),
            previous: AnyView(diagnosticView1())
        )
    }
}

// Head Lights - Page 3
struct diagnosticView3: View {
    var body: some View {
        DiagnosticPage(
            category: .underHood,
            sectionTitle: "Head Lights",
            logKey: "Head Lights",
            logLabel: "Head Lights",
            photoKey: "page3",
            photoButtonTitle: "Take Photo for Head Lights",
            next: AnyView(diagnosticView4()),
            previous: AnyView(diagnosticView2())
        )
    }
}

// Air Filter - Page 4
struct diagnosticView4: View {
    var body: some View {
        DiagnosticPage(
            category: .underHood,
            sectionTitle: "Air Filter",
            logKey: "Air Filter",
            logLabel: "Air Filter",
            photoKey: "page4",
            photoButtonTitle: "Take Photo for Air Filter",
            next: AnyView(diagnosticView5()),
            previous: AnyView(diagnosticView3())
        )
    }
}

// PCV Valve - Page 5
struct diagnosticView5: View {
    var body: some View {
        DiagnosticPage(
            category: .underHood,
            sectionTitle: "PCV Valve",
            logKey: "PCV Valve",
            logLabel: "PCV Valve",
            photoKey: "page5",
            photoButtonTitle: "Take Photo for PCV Valve",
            next: AnyView(diagnosticView6()),
            previous: AnyView(diagnosticView4())
        )
    }
}
// Washer Fluid - Page 6
struct diagnosticView6: View {
    var body: some View {
        DiagnosticPage(
            category: .underHood,
            sectionTitle: "Washer Fluid",
            logKey: "Washer Fluid",
            logLabel: "Washer Fluid",
            photoKey: "page6",
            photoButtonTitle: "Take Photo for Washer Fluid",
            next: AnyView(diagnosticView7()),
            previous: AnyView(diagnosticView5())
        )
    }
}

// Engine Oil - Page 7
struct diagnosticView7: View {
    var body: some View {
        DiagnosticPage(
            category: .underHood,
            sectionTitle: "Engine Oil",
            logKey: "Engine Oil",
            logLabel: "Engine Oil",
            photoKey: "page7",
            photoButtonTitle: "Take Photo for Engine Oil",
            next: AnyView(diagnosticView8()),
            previous: AnyView(diagnosticView6())
        )
    }
}

// Power Steering Fluid - Page 8
struct diagnosticView8: View {
    var body: some View {
        DiagnosticPage(
            category: .underHood,
            sectionTitle: "Power Steering Fluid",
            logKey: "Power Steering Fluid",
            logLabel: "Power Steering Fluid",
            photoKey: "page8",
            photoButtonTitle: "Take Photo for Power Steering Fluid",
            next: AnyView(diagnosticView9()),
            previous: AnyView(diagnosticView7())
        )
    }
}

// Master Cylinder Fluid Level - Page 9
struct diagnosticView9: View {
    var body: some View {
        DiagnosticPage(
            category: .underHood,
            sectionTitle: "Master Cylinder Fluid Level",
            logKey: "Master Cylinder Fluid Level",
            logLabel: "Master Cylinder Fluid Level",
            photoKey: "page9",
            photoButtonTitle: "Take Photo for Master Cylinder Fluid Level",
            next: AnyView(diagnosticView10()),
            previous: AnyView(diagnosticView8())
        )
    }
}

// Brake Fluid - Page 10
struct diagnosticView10: View {
    var body: some View {
        DiagnosticPage(
            category: .underHood,
            sectionTitle: "Brake Fluid",
            logKey: "Brake Fluid",
            logLabel: "Brake Fluid",
            photoKey: "page10",
            photoButtonTitle: "Take Photo for Brake Fluid",
            next: AnyView(diagnosticView11()),
            previous: AnyView(diagnosticView9())
        )
    }
}

// Coolant Hoses - Page 11
struct diagnosticView11: View {
    var body: some View {
        DiagnosticPage(
            category: .underHood,
            sectionTitle: "Coolant Hoses",
            logKey: "Coolant Hoses",
            logLabel: "Coolant Hoses",
            photoKey: "page11",
            photoButtonTitle: "Take Photo for Collant Hoses",
            next: AnyView(diagnosticView12()),
            previous: AnyView(diagnosticView10())
        )
    }
}

// Engine Coolant - Page 12
struct diagnosticView12: View {
    var body: some View {
        DiagnosticPage(
            category: .underHood,
            sectionTitle: "Engine Coolant",
            logKey: "Engine Coolant",
            logLabel: "Engine Coolant",
            photoKey: "page12",
            photoButtonTitle: "Take Photo for Engine Coolant",
            next: AnyView(diagnosticView13()),
            previous: AnyView(diagnosticView11())
        )
    }
}

// Battery Test - Page 13
struct diagnosticView13: View {
    var body: some View {
        DiagnosticPage(
            category: .underHood,
            sectionTitle: "Battery Test",
            logKey: "Battery Test",
            logLabel: "Battery Test",
            photoKey: "page13",
            photoButtonTitle: "Take Photo for Battery Test",
            next: AnyView(diagnosticView14()),
            previous: AnyView(diagnosticView12())
        )
    }
}

// Battery Accessories - Page 14
struct diagnosticView14: View {
    var body: some View {
        DiagnosticPage(
            category: .underHood,
            sectionTitle: "Battery Accessories",
            logKey: "Battery Accessories",
            logLabel: "Battery Accessories",
            photoKey: "page14",
            photoButtonTitle: "Take Photo for Battery Accessories",
            next: AnyView(diagnosticView15()),
            previous: AnyView(diagnosticView13())
        )
    }
}

// Start/Charge - Page 15
struct diagnosticView15: View {
    var body: some View {
        DiagnosticPage(
            category: .underHood,
            sectionTitle: "Start/Charge",
            logKey: "Start/Charge",
            logLabel: "Start/Charge",
            photoKey: "page15",
            photoButtonTitle: "Take Photo for Start/Charge",
            next: AnyView(diagnosticView16()),
            previous: AnyView(diagnosticView14())
        )
    }
}

// Belts - Page 16
struct diagnosticView16: View {
    var body: some View {
        DiagnosticPage(
            category: .underHood,
            sectionTitle: "Belts",
            logKey: "Belts",
            logLabel: "Belts",
            photoKey: "page16",
            photoButtonTitle: "Take Photo for Belts",
            next: AnyView(diagnosticView17()),
            previous: AnyView(diagnosticView15())
        )
    }
}

// Spark Plugs - Page 17
struct diagnosticView17: View {
    var body: some View {
        DiagnosticPage(
            category: .underHood,
            sectionTitle: "Spark Plugs",
            logKey: "Spark Plugs",
            logLabel: "Spark Plugs",
            photoKey: "page17",
            photoButtonTitle: "Take Photo for Spark Plugs",
            next: AnyView(diagnosticView18()),
            previous: AnyView(diagnosticView16())
        )
    }
}

// Fuel Filter - Page 18
struct diagnosticView18: View {
    var body: some View {
        DiagnosticPage(
            category: .underHood,
            sectionTitle: "Fuel Filter",
            logKey: "Fuel Filter",
            logLabel: "Fuel Filter",
            photoKey: "page18",
            photoButtonTitle: "Take Photo for Fuel Filter",
            next: AnyView(diagnosticView19()),
            previous: AnyView(diagnosticView17())
        )
    }
}

// Ignition Wires - Page 19
struct diagnosticView19: View {
    var body: some View {
        DiagnosticPage(
            category: .underHood,
            sectionTitle: "Ignition Wires",
            logKey: "Ignition Wires",
            logLabel: "Ignition Wires",
            photoKey: "page19",
            photoButtonTitle: "Take Photo for Ignition Wires",
            next: AnyView(diagnosticView20()),
            previous: AnyView(diagnosticView18())
        )
    }
}

// Valve Cover Gasket - Page 20
struct diagnosticView20: View {
    var body: some View {
        DiagnosticPage(
            category: .underHood,
            sectionTitle: "Valve Cover Gasket",
            logKey: "Valve Cover Gasket",
            logLabel: "Valve Cover Gasket",
            photoKey: "page20",
            photoButtonTitle: "Take Photo for Valve Cover Gasket",
            next: AnyView(diagnosticView21()),
            previous: AnyView(diagnosticView19())
        )
    }
}

// Power Steering Hose - Page 21
struct diagnosticView21: View {
    var body: some View {
        DiagnosticPage(
            category: .underHood,
            sectionTitle: "Power Steering Hose",
            logKey: "Power Steering Hose",
            logLabel: "Power Steering Hose",
            photoKey: "page21",
            photoButtonTitle: "Take Photo for Power Steering Hose",
            next: AnyView(diagnosticView22()),
            previous: AnyView(diagnosticView20())
        )
    }
}

// Timing Belt - Page 22
struct diagnosticView22: View {
    var body: some View {
        DiagnosticPage(
            category: .underHood,
            sectionTitle: "Timing Belt",
            logKey: "Timing Belt",
            logLabel: "Timing Belt",
            photoKey: "page22",
            photoButtonTitle: "Take Photo for Timing Belt",
            next: AnyView(diagnosticView23()),
            previous: AnyView(diagnosticView21())
        )
    }
}

// Transfer Case/Differential Fluid - Page 23
struct diagnosticView23: View {
    var body: some View {
        DiagnosticPage(
            category: .underHood,
            sectionTitle: "Transfer Case/Differential Fluid",
            logKey: "Transfer Case/Differential Fluid",
            logLabel: "Transfer Case/Differential Fluid",
            photoKey: "page23",
            photoButtonTitle: "Take Photo for Transfer Case/Differential Fluid",
            next: AnyView(diagnosticView24()),
            previous: AnyView(diagnosticView22())
        )
    }
}

// Transmission Fluid - Page 24
struct diagnosticView24: View {
    var body: some View {
        DiagnosticPage(
            category: .underHood,
            sectionTitle: "Transmission Fluid",
            logKey: "Transmission Fluid",
            logLabel: "Transmission Fluid",
            photoKey: "page24",
            photoButtonTitle: "Take Photo for Transmission Fluid",
            next: AnyView(diagnosticView25()),
            previous: AnyView(diagnosticView23())
        )
    }
}

