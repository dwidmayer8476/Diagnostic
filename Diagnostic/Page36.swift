
import SwiftUI

struct diagnosticView36: View {
    @EnvironmentObject var photoStore: PhotoStore
    @EnvironmentObject var printStore: PrintStore
    struct DiagnosticStatus: CustomStringConvertible {
        var red: Bool
        var yellow: Bool
        var green: Bool
        var description: String { "DiagnosticStatus(red: \(red), yellow: \(yellow), green: \(green))" }
    }
    
    @State private var status = DiagnosticStatus(red: false, yellow: false, green: false)
    @State private var showCamera = false
    private let photoKey = "page36"
    private var selectedColor: String {
        if status.red { return "Red" }
        if status.yellow { return "Yellow" }
        if status.green { return "Green" }
        return "None"
    }
    
    var body: some View {
        VStack(spacing: 20) {
            
            Text("Steering & Suspension")
                .font(.largeTitle)
                .foregroundStyle(.red)
                .padding(10)
            
            Text("Struts")
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
                let message = "page36: status=\(selectedColor)"
                printStore.log(message)
            }
            .font(.largeTitle)
            .foregroundStyle(.red)
            
            Button("Take Photo for Page 36") {
                showCamera = true
            }
            .buttonStyle(.bordered)
            NavigationLink("Next Page") {
                diagnosticView37()
            }
            
            NavigationLink("Previous Page") {
                diagnosticView35()
            }
        }
        .sheet(isPresented: $showCamera) {
            CameraPicker(images: .constant([])) { captured in
                photoStore.imagesByKey[photoKey] = captured
            }
        }
    }
}







