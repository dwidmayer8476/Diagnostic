import SwiftUI

struct CompletionLabel: View {
    @EnvironmentObject var printStore: PrintStore
    var title: String
    var systemImage: String
    var logKey: String
    var body: some View {
        HStack {
            Label(title, systemImage: systemImage)
            Spacer()
            if printStore.messagesByKey[logKey] != nil {
                Image(systemName: "checkmark.circle.fill")
                    .foregroundStyle(.green)
            }
        }
    }
}

struct GiantDiagnosticList: View {
    var body: some View {
        List {
            Section("Basic Info") {
                NavigationLink {
                    DiagnosticView1()
                } label: {
                    CompletionLabel(title: "User & Car Information", systemImage: "car.badge.gearshape", logKey: "User & Car Information")
                }
                
            }
            
            Section("Underhood Maintenance") {
                NavigationLink { diagnosticView1() } label: { CompletionLabel(title: "Under Hood Overview", systemImage: "wrench", logKey: "Under Hood Overview") }
                NavigationLink { diagnosticView2() } label: { CompletionLabel(title: "Wiper Blades", systemImage: "windshield.front.and.wiper", logKey: "Wiper Blades") }
                NavigationLink { diagnosticView3() } label: { CompletionLabel(title: "Headlights", systemImage: "lightbulb", logKey: "Head Lights") }
                NavigationLink { diagnosticView4() } label: { CompletionLabel(title: "Air Filter", systemImage: "air.conditioner.horizontal", logKey: "Air Filter") }
                NavigationLink { diagnosticView5() } label: { CompletionLabel(title: "PCV Valve", systemImage: "spigot", logKey: "PCV Valve") }
                NavigationLink { diagnosticView6() } label: { CompletionLabel(title: "Washer Fluid", systemImage: "windshield.front.and.spray", logKey: "Washer Fluid") }
                NavigationLink { diagnosticView7() } label: { CompletionLabel(title: "Engine Oil", systemImage: "engine.combustion.badge.exclamationmark", logKey: "Engine Oil") }
                NavigationLink { diagnosticView8() } label: { CompletionLabel(title: "Power Steering Fluid", systemImage: "waterbottle.fill", logKey: "Power Steering Fluid") }
                NavigationLink { diagnosticView9() } label: { CompletionLabel(title: "Master Cylinder Fluid Level", systemImage: "minus.plus.lines.measurement.horizontal.aligned.bottom", logKey: "Master Cylinder Fluid Level") }
                NavigationLink { diagnosticView10() } label: { CompletionLabel(title: "Brake Fluid", systemImage: "fluid.brakesignal", logKey: "Brake Fluid") }
                NavigationLink { diagnosticView11() } label: { CompletionLabel(title: "Coolant Hoses", systemImage: "pipe.and.drop", logKey: "Coolant Hoses") }
                NavigationLink { diagnosticView12() } label: { CompletionLabel(title: "Engine Coolant", systemImage: "fluid.coolant", logKey: "Engine Coolant") }
                NavigationLink { diagnosticView13() } label: { CompletionLabel(title: "Battery Test", systemImage: "minus.plus.batteryblock.exclamationmark", logKey: "Battery Test") }
                NavigationLink { diagnosticView14() } label: { CompletionLabel(title: "Battery Accessories", systemImage: "batteryblock.slash", logKey: "Battery Accessories") }
                NavigationLink { diagnosticView15() } label: { CompletionLabel(title: "Start / Charge", systemImage: "bolt.batteryblock.fill", logKey: "Start/Charge") }
                NavigationLink { diagnosticView16() } label: { CompletionLabel(title: "Belts", systemImage: "figure.seated.seatbelt", logKey: "Belts") }
                NavigationLink { diagnosticView17() } label: { CompletionLabel(title: "Spark Plugs", systemImage: "powercord", logKey: "Spark Plugs") }
                NavigationLink { diagnosticView18() } label: { CompletionLabel(title: "Fuel Filter", systemImage: "fuel.filter.water", logKey: "Fuel Filter") }
                NavigationLink { diagnosticView19() } label: { CompletionLabel(title: "Ignition Wires", systemImage: "cable.coaxial", logKey: "Ignition Wires") }
                NavigationLink { diagnosticView20() } label: { CompletionLabel(title: "Valve Cover Gasket", systemImage: "ev.plug.dc.nacs", logKey: "Valve Cover Gasket") }
                NavigationLink { diagnosticView21() } label: { CompletionLabel(title: "Power Steering Hose", systemImage: "water.waves", logKey: "Power Steering Hose") }
                NavigationLink { diagnosticView23() } label: { CompletionLabel(title: "Transfer Case/Differential Fluid", systemImage: "briefcase.fill", logKey: "Transfer Case/Differential Fluid") }
                NavigationLink { diagnosticView24() } label: { CompletionLabel(title: "Transmission Fluid", systemImage: "fluid.transmission", logKey: "Transmission Fluid") }
            }
            Section("Exhaust System") {
                NavigationLink { diagnosticView25() } label: { CompletionLabel(title: "Exhaust System", systemImage: "heat.waves", logKey: "Exhaust System") }
            }
            Section("Steering Suspension") {
                NavigationLink { diagnosticView26() } label: { CompletionLabel(title: "Steering Components", systemImage: "steeringwheel", logKey: "Steering Components") }
                NavigationLink { diagnosticView27() } label: { CompletionLabel(title: "Suspension Components", systemImage: "car.2", logKey: "Suspension Components") }
                NavigationLink { diagnosticView28() } label: { CompletionLabel(title: "Shocks / Struts", systemImage: "figure.stand.line.dotted.figure.stand", logKey: "Shocks/Struts") }
                NavigationLink { diagnosticView29() } label: { CompletionLabel(title: "Ball Joints", systemImage: "circle.grid.cross", logKey: "Ball Joints") }
                NavigationLink { diagnosticView30() } label: { CompletionLabel(title: "Tie Rod Ends", systemImage: "cable.connector", logKey: "Tie Rod Ends") }
                NavigationLink { diagnosticView31() } label: { CompletionLabel(title: "Control Arms", systemImage: "hand.raised", logKey: "Control Arms") }
                NavigationLink { diagnosticView32() } label: { CompletionLabel(title: "Bushings", systemImage: "circle.dashed.inset.filled", logKey: "Bushings") }
                NavigationLink { diagnosticView33() } label: { CompletionLabel(title: "Sway Bar Links", systemImage: "link", logKey: "Sway Bar Links") }
                NavigationLink { diagnosticView34() } label: { CompletionLabel(title: "Wheel Bearings", systemImage: "gearshape", logKey: "Wheel Bearings") }
                NavigationLink { diagnosticView35() } label: { CompletionLabel(title: "CV Joints / Boots", systemImage: "arrow.triangle.capsulepath", logKey: "CV Joints/Boots") }
                NavigationLink { diagnosticView36() } label: { CompletionLabel(title: "Rack & Pinion", systemImage: "wrench.adjustable", logKey: "Rack & Pinion") }
                NavigationLink { diagnosticView37() } label: { CompletionLabel(title: "Power Steering Pump", systemImage: "steeringwheel.and.liquid.wave", logKey: "Power Steering Pump") }
            }
            NavigationLink { PrintSummaryView () } label: { Label("Finish Diagnostic", systemImage: "rectangle.pattern.checkered") }
        }
    }
}

