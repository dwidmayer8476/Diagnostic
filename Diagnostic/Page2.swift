import SwiftUI

struct diagnosticView2: View {
    @EnvironmentObject var photoStore: PhotoStore
    
    @State var car = carInfoClass(carVin: "", make: "", year: 0000, carOwner: "")
    @State private var showCamera = false
    private let photoKey = "page2"
    
    struct DiagnosticStatus: CustomStringConvertible {
        var red: Bool
        var yellow: Bool
        var green: Bool
        var description: String { "DiagnosticStatus(red: \(red), yellow: \(yellow), green: \(green))" }
    }
    
    @State private var status = DiagnosticStatus(red: false, yellow: false, green: false)
    private var selectedColor: String {
        if status.red { return "Red" }
        if status.yellow { return "Yellow" }
        if status.green { return "Green" }
        return "None"
    }
    var body: some View {
        VStack(spacing: 20) {
            
            Text("Under Hood / Maintenance Service")
                .font(.largeTitle)
                .foregroundStyle(.red)
                .padding(10)
            
            Text("Wiper Blades")
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
            Text("status: \(selectedColor)")
            
            
            Button("Take Photo for Page 2") {
                showCamera = true
            }
            .buttonStyle(.bordered)
            
            NavigationLink("Next Page") {
                diagnosticView3()
            }
        }
        .sheet(isPresented: $showCamera) {
            CameraPicker(images: .constant([])) { captured in
                photoStore.imagesByKey[photoKey] = captured
            }
        }
    }
}

