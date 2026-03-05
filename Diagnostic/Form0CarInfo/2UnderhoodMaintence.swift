import SwiftUI
import UIKit

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
            next: diagnosticView3(),
            previous: diagnosticView1()
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
            next: diagnosticView4(),
            previous: diagnosticView2()
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
            next: diagnosticView5(),
            previous: diagnosticView3()
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
            next: diagnosticView6(),
            previous: diagnosticView4()
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
            next: diagnosticView7(),
            previous: diagnosticView5()
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
            next: diagnosticView8(),
            previous: diagnosticView6()
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
            next: diagnosticView9(),
            previous: diagnosticView7()
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
            next: diagnosticView10(),
            previous: diagnosticView8()
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
            next: diagnosticView11(),
            previous: diagnosticView9()
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
            next: diagnosticView12(),
            previous: diagnosticView10()
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
            next: diagnosticView13(),
            previous: diagnosticView11()
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
            next: diagnosticView14(),
            previous: diagnosticView12()
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
            next: diagnosticView15(),
            previous: diagnosticView13()
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
            next: diagnosticView16(),
            previous: diagnosticView14()
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
            next: diagnosticView17(),
            previous: diagnosticView15()
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
            next: diagnosticView18(),
            previous: diagnosticView16()
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
            next: diagnosticView19(),
            previous: diagnosticView17()
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
            next: diagnosticView20(),
            previous: diagnosticView18()
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
            next: diagnosticView21(),
            previous: diagnosticView19()
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
            next: diagnosticView22(),
            previous: diagnosticView20()
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
            next: diagnosticView23(),
            previous: diagnosticView21()
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
            next: diagnosticView24(),
            previous: diagnosticView22()
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
            next: diagnosticView25(),
            previous: diagnosticView23()
        )
    }
}


