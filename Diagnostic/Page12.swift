
import SwiftUI

struct diagnosticView12: View {
    @EnvironmentObject var photoStore: PhotoStore
    @EnvironmentObject var printStore: PrintStore
    struct DiagnosticStatus: CustomStringConvertible {
        var red: Bool
        var yellow: Bool
        var green: Bool
        var description: String { "DiagnosticStatus(red: \(red), yellow: \(yellow), green: \(green))" }
    }
    @State private var showCamera = false
    private let photoKey = "page12"
    
    private var selectedColor: String {
        if status.red { return "Red" }
        if status.yellow { return "Yellow" }
        if status.green { return "Green" }
        return "None"
    }
    
    @State private var status = DiagnosticStatus(red: false, yellow: false, green: false)
    var body: some View {
        VStack(spacing: 20) {
            
            Text("Under Hood / Maintenance Service")
                .font(.largeTitle)
                .foregroundStyle(.red)
                .padding(10)
            
            Text("Engine Coolant")
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
            
            Button("Take Photo for Page 12") {
                showCamera = true
            }
            .buttonStyle(.bordered)
            NavigationLink("Next Page") {
                diagnosticView13()
            }
            
            NavigationLink("Previous Page") {
                diagnosticView11()
            }
        }
        .sheet(isPresented: $showCamera) {
            CameraPicker(images: .constant([])) { captured in
                photoStore.imagesByKey[photoKey] = captured
            }
        }
    }
}


