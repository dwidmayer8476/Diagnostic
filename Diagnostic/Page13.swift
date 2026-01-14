
import SwiftUI

struct diagnosticView13: View {

    struct DiagnosticStatus: CustomStringConvertible {
        var red: Bool
        var yellow: Bool
        var green: Bool
        var description: String { "DiagnosticStatus(red: \(red), yellow: \(yellow), green: \(green))" }
    }

    @State private var status = DiagnosticStatus(red: false, yellow: false, green: false)
    var body: some View {
        VStack(spacing: 20) {

            Text("Under Hood / Maintenance Service")
                .font(.largeTitle)
                .foregroundStyle(.red)
                .padding(10)

            Text("Brake Fluid")
                .font(.largeTitle)

            Image("Rules")

            Button("Red") {
                status = DiagnosticStatus(red: true, yellow: false, green: false)
            }

            Button("Yellow") {
                status = DiagnosticStatus(red: false, yellow: true, green: false)
            }

            Button("Green") {
                status = DiagnosticStatus(red: false, yellow: false, green: true)
            }

            Button("Confirm?") {
                print(status)
            }
            .font(.largeTitle)
            .foregroundStyle(.red)

            NavigationLink("Next Page") {
                diagnosticView14()
            }

            NavigationLink("Previous Page") {
                diagnosticView12()
            }
        }
    }
}



