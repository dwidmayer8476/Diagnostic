import SwiftUI
import UIKit

// Wiper Blades - Page 2
struct diagnosticView2: View {
    var body: some View {
        DiagnosticPage(
            sectionTitle: "Wiper Blades",
            logKey: "WiperBlades",
            logLabel: "WiperBlades",
            photoKey: "page2",
            photoButtonTitle: "Take Photo for Page 2",
            next: diagnosticView3(),
            previous: diagnosticView1()
        )
    }
}

// Head Lights - Page 3
struct diagnosticView3: View {
    var body: some View {
        DiagnosticPage(
            sectionTitle: "Head Lights",
            logKey: "HeadLights",
            logLabel: "HeadLights",
            photoKey: "page3",
            photoButtonTitle: "Take Photo for Page 3",
            next: diagnosticView4(),
            previous: diagnosticView2()
        )
    }
}

// Air Filter - Page 4
struct diagnosticView4: View {
    var body: some View {
        DiagnosticPage(
            sectionTitle: "Air Filter",
            logKey: "AirFilter",
            logLabel: "AirFilter",
            photoKey: "page4",
            photoButtonTitle: "Take Photo for Page 4",
            next: diagnosticView5(),
            previous: diagnosticView3()
        )
    }
}

// PCV Valve - Page 5
struct diagnosticView5: View {
    var body: some View {
        DiagnosticPage(
            sectionTitle: "PCV Valve",
            logKey: "PCVValve",
            logLabel: "PCVValve",
            photoKey: "page5",
            photoButtonTitle: "Take Photo for Page 5",
            next: diagnosticView6(),
            previous: diagnosticView4()
        )
    }
}
// Washer Fluid - Page 6
struct diagnosticView6: View {
    var body: some View {
        DiagnosticPage(
            sectionTitle: "Washer Fluid",
            logKey: "WasherFluid",
            logLabel: "WasherFluid",
            photoKey: "page6",
            photoButtonTitle: "Take Photo for Page 6",
            next: diagnosticView7(),
            previous: diagnosticView5()
        )
    }
}

// Engine Oil - Page 7
struct diagnosticView7: View {
    var body: some View {
        DiagnosticPage(
            sectionTitle: "Engine Oil",
            logKey: "EngineOil",
            logLabel: "EngineOil",
            photoKey: "page7",
            photoButtonTitle: "Take Photo for Page 7",
            next: diagnosticView8(),
            previous: diagnosticView6()
        )
    }
}

// Power Steering Fluid - Page 8
struct diagnosticView8: View {
    var body: some View {
        DiagnosticPage(
            sectionTitle: "Power Steering Fluid",
            logKey: "PowerSteeringFluid",
            logLabel: "PowerSteeringFluid",
            photoKey: "page8",
            photoButtonTitle: "Take Photo for Page 8",
            next: diagnosticView9(),
            previous: diagnosticView7()
        )
    }
}

// Master Cylinder Fluid Level - Page 9
struct diagnosticView9: View {
    var body: some View {
        DiagnosticPage(
            sectionTitle: "Master Cylinder Fluid Level",
            logKey: "MasterCylFluidLevel",
            logLabel: "MasterCylFluidLevel",
            photoKey: "page9",
            photoButtonTitle: "Take Photo for Page 9",
            next: diagnosticView10(),
            previous: diagnosticView8()
        )
    }
}

// Brake Fluid - Page 10
struct diagnosticView10: View {
    var body: some View {
        DiagnosticPage(
            sectionTitle: "Brake Fluid",
            logKey: "BrakeFluid",
            logLabel: "BrakeFluid",
            photoKey: "page10",
            photoButtonTitle: "Take Photo for Page 10",
            next: diagnosticView11(),
            previous: diagnosticView9()
        )
    }
}

// Coolant Hoses - Page 11
struct diagnosticView11: View {
    var body: some View {
        DiagnosticPage(
            sectionTitle: "Coolant Hoses",
            logKey: "CoolantHoses",
            logLabel: "CoolantHoses",
            photoKey: "page11",
            photoButtonTitle: "Take Photo for Page 11",
            next: diagnosticView12(),
            previous: diagnosticView10()
        )
    }
}

// Engine Coolant - Page 12
struct diagnosticView12: View {
    var body: some View {
        DiagnosticPage(
            sectionTitle: "Engine Coolant",
            logKey: "EngineCoolant",
            logLabel: "EngineCoolant",
            photoKey: "page12",
            photoButtonTitle: "Take Photo for Page 12",
            next: diagnosticView13(),
            previous: diagnosticView11()
        )
    }
}

// Battery Test - Page 13
struct diagnosticView13: View {
    var body: some View {
        DiagnosticPage(
            sectionTitle: "Battery Test",
            logKey: "BatteryTest",
            logLabel: "BatteryTest",
            photoKey: "page13",
            photoButtonTitle: "Take Photo for Page 13",
            next: diagnosticView14(),
            previous: diagnosticView12()
        )
    }
}

// Battery Accessories - Page 14
struct diagnosticView14: View {
    var body: some View {
        DiagnosticPage(
            sectionTitle: "Battery Accessories",
            logKey: "BatteryAccessories",
            logLabel: "BatteryAccessories",
            photoKey: "page14",
            photoButtonTitle: "Take Photo for Page 14",
            next: diagnosticView15(),
            previous: diagnosticView13()
        )
    }
}

// Start/Charge - Page 15
struct diagnosticView15: View {
    var body: some View {
        DiagnosticPage(
            sectionTitle: "Start/Charge",
            logKey: "StartCharge",
            logLabel: "StartCharge",
            photoKey: "page15",
            photoButtonTitle: "Take Photo for Page 15",
            next: diagnosticView16(),
            previous: diagnosticView14()
        )
    }
}

// Belts - Page 16
struct diagnosticView16: View {
    var body: some View {
        DiagnosticPage(
            sectionTitle: "Belts",
            logKey: "Belts",
            logLabel: "Belts",
            photoKey: "page16",
            photoButtonTitle: "Take Photo for Page 16",
            next: diagnosticView17(),
            previous: diagnosticView15()
        )
    }
}

// Spark Plugs - Page 17
struct diagnosticView17: View {
    var body: some View {
        DiagnosticPage(
            sectionTitle: "Spark Plugs",
            logKey: "SparkPlugs",
            logLabel: "SparkPlugs",
            photoKey: "page17",
            photoButtonTitle: "Take Photo for Page 17",
            next: diagnosticView18(),
            previous: diagnosticView16()
        )
    }
}

// Fuel Filter - Page 18
struct diagnosticView18: View {
    var body: some View {
        DiagnosticPage(
            sectionTitle: "Fuel Filter",
            logKey: "FuelFilter",
            logLabel: "FuelFilter",
            photoKey: "page18",
            photoButtonTitle: "Take Photo for Page 18",
            next: diagnosticView19(),
            previous: diagnosticView17()
        )
    }
}

// Ignition Wires - Page 19
struct diagnosticView19: View {
    var body: some View {
        DiagnosticPage(
            sectionTitle: "Ignition Wires",
            logKey: "IgnitionWires",
            logLabel: "IgnitionWires",
            photoKey: "page19",
            photoButtonTitle: "Take Photo for Page 19",
            next: diagnosticView20(),
            previous: diagnosticView18()
        )
    }
}

// Valve Cover Gasket - Page 20
struct diagnosticView20: View {
    var body: some View {
        DiagnosticPage(
            sectionTitle: "Valve Cover Gasket",
            logKey: "ValveCoverGasket",
            logLabel: "ValveCoverGasket",
            photoKey: "page20",
            photoButtonTitle: "Take Photo for Page 20",
            next: diagnosticView21(),
            previous: diagnosticView19()
        )
    }
}

// Power Steering Hose - Page 21
struct diagnosticView21: View {
    var body: some View {
        DiagnosticPage(
            sectionTitle: "Power Steering Hose",
            logKey: "PowerSteeringHose",
            logLabel: "PowerSteeringHose",
            photoKey: "page21",
            photoButtonTitle: "Take Photo for Page 21",
            next: diagnosticView22(),
            previous: diagnosticView20()
        )
    }
}

// Timing Belt - Page 22
struct diagnosticView22: View {
    var body: some View {
        DiagnosticPage(
            sectionTitle: "Timing Belt",
            logKey: "TimingBelt",
            logLabel: "TimingBelt",
            photoKey: "page22",
            photoButtonTitle: "Take Photo for Page 22",
            next: diagnosticView23(),
            previous: diagnosticView21()
        )
    }
}

// Transfer Case / Diff Fluid - Page 23
struct diagnosticView23: View {
    var body: some View {
        DiagnosticPage(
            sectionTitle: "Transfer Case / Diff Fluid",
            logKey: "TransferCaseDiffFluid",
            logLabel: "TransferCaseDiffFluid",
            photoKey: "page23",
            photoButtonTitle: "Take Photo for Page 23",
            next: diagnosticView24(),
            previous: diagnosticView22()
        )
    }
}

// Transmission Fluid - Page 24
struct diagnosticView24: View {
    var body: some View {
        DiagnosticPage(
            sectionTitle: "Transmission Fluid",
            logKey: "TransmissionFluid",
            logLabel: "TransmissionFluid",
            photoKey: "page24",
            photoButtonTitle: "Take Photo for Page 24",
            next: diagnosticView25(),
            previous: diagnosticView23()
        )
    }
}


