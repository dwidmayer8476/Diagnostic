import SwiftUI

struct MainMenu: View {
    var body: some View {
        NavigationStack {
            List {
                NavigationLink {
                    GiantDiagnosticList()
                } label: {
                    Label("Begin Diagnostic", systemImage: "play.circle.fill")
                }
                NavigationLink {
                    DiagnosticView1()
                } label: {
                    Label("Car Information", systemImage: "car.fill")
                }
            }
            .navigationTitle("Main Menu")
        }
    }
}

#Preview {
    MainMenu()
        .environmentObject(PhotoStore())
        .environmentObject(PrintStore())
}
