import SwiftUI

struct GiantDiagnosticList: View {
    var body: some View {
        List {
            Section("Basic Info") {
                NavigationLink {
                    DiagnosticView1()
                } label: {
                    Label("User & Car Information", systemImage: "person.crop.circle.badge.car")
                }
                
            }
            
            Section("Underhood Maintenance") {
                NavigationLink { diagnosticView1() } label: { Label("Under Hood Overview", systemImage: "wrench") }
                NavigationLink { diagnosticView2() } label: { Label("Wiper Blades", systemImage: "windshield.front.and.wiper") }
                NavigationLink { diagnosticView3() } label: { Label("Headlights", systemImage: "lightbulb") }
                NavigationLink { diagnosticView4() } label: { Label("Air Filter", systemImage: "air.conditioner.horizontal") }
                NavigationLink { diagnosticView5() } label: { Label("PCV Valve", systemImage: "spigot") }
                NavigationLink { diagnosticView6() } label: { Label("Washer Fluid", systemImage: "windshield.front.and.spray") }
                NavigationLink { diagnosticView7() } label: { Label("Engine Oil", systemImage: "engine.combustion.badge.exclamationmark") }
                NavigationLink { diagnosticView8() } label: { Label("Power Steering Fluid", systemImage: "waterbottle.fill") }
                NavigationLink { diagnosticView9() } label: { Label("Master Cylinder Fluid Level", systemImage: "minus.plus.lines.measurement.horizontal.aligned.bottom") }
                NavigationLink { diagnosticView10() } label: { Label("Brake Fluid", systemImage: "fluid.brakesignal") }
                NavigationLink { diagnosticView11() } label: { Label("Coolant Hoses", systemImage: "pipe.and.drop") }
                NavigationLink { diagnosticView12() } label: { Label("Coolant Engine", systemImage: "fluid.coolant") }
                NavigationLink { diagnosticView13() } label: { Label("Battery Test", systemImage: "minus.plus.batteryblock.exclamationmark") }
                NavigationLink { diagnosticView14() } label: { Label("Battery Accessories", systemImage: "batteryblock.slash") }
                NavigationLink { diagnosticView15() } label: { Label("Start / Charge", systemImage: "bolt.batteryblock.fill") }
                NavigationLink { diagnosticView16() } label: { Label("Belts", systemImage: "figure.seated.seatbelt") }
                NavigationLink { diagnosticView17() } label: { Label("Spark Plugs", systemImage: "powercord") }
                NavigationLink { diagnosticView18() } label: { Label("Fuel Filter", systemImage: "fuel.filter.water") }
                NavigationLink { diagnosticView19() } label: { Label("Ignition Wires", systemImage: "cable.coaxial") }
                NavigationLink { diagnosticView20() } label: { Label("Valve Cover Gasket", systemImage: "ev.plug.dc.nacs") }
                NavigationLink { diagnosticView21() } label: { Label("Timing Belt", systemImage: "timelapse") }
                NavigationLink { diagnosticView22() } label: { Label("name", systemImage: "symbol") }
            }
            Section("Exhaust System") {
                NavigationLink { diagnosticView25() } label: { Label("Exhaust System", systemImage: "heat.waves") }
            }
            Section("Steering Suspension") {
                NavigationLink { diagnosticView26() } label: { Label("Steering Compenents", systemImage: "steeringwheel") }
            }
                NavigationLink { PrintSummaryView () } label: { Label("Finish Diagnostic", systemImage: "rectangle.pattern.checkered") }
        }
    }
}


