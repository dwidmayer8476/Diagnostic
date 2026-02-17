import SwiftUI

struct diagnosticView10: View {
    @EnvironmentObject var photoStore: PhotoStore
    @EnvironmentObject var printStore: PrintStore
    struct DiagnosticStatus: CustomStringConvertible {
        var red: Bool
        var yellow: Bool
        var green: Bool
        var description: String { "DiagnosticStatus(red: \(red), yellow: \(yellow), green: \(green))" }
    }
    
    @State private var showCamera = false
    @State private var notes: String = ""
    private let photoKey = "page10"
    
    private var selectedColor: String {
        if status.red { return "Red" }
        if status.yellow { return "Yellow" }
        if status.green { return "Green" }
        return "None"
    }
    
    @State private var status = DiagnosticStatus(red: false, yellow: false, green: false)
    var body: some View {
        VStack(spacing: 20) {
            
            Image("Rules")
                .resizable()
                .scaledToFit()
                .padding()
            
            Text("Under Hood / Maintenance Service")
                .font(.largeTitle)
                .foregroundStyle(.red)
                .padding(10)
            
            Text("Brake Fluid")
                .font(.largeTitle)
            
            HStack(spacing: 25) {
                Button("Green") {
                    status = DiagnosticStatus(red: false, yellow: false, green: true)
                }
                Button("Yellow") {
                    status = DiagnosticStatus(red: false, yellow: true, green: false)
                }
                Button("Red") {
                    status = DiagnosticStatus(red: true, yellow: false, green: false)
                }            }
            
            Text("status: \(selectedColor)")
            
            TextField("Enter Notes", text: $notes)
                .frame(width: 300, height: 50)
                .textFieldStyle(.roundedBorder)
            
            Button("Confirm?") {
                let message = """
                page10: status=\(selectedColor)
                notes: \(notes)
                """
                
                printStore.log(message,for: "BrakeFluid")
            }
            .font(.largeTitle)
            .foregroundStyle(.red)
            .buttonStyle(.bordered)
            .buttonBorderShape(.roundedRectangle)
            .controlSize(.large)
            
            
            Button("Take Photo for Page 10") {
                showCamera = true
            }
            .buttonStyle(.bordered)
            NavigationLink("Next Page") {
                diagnosticView11()
            }
            
            NavigationLink("Previous Page") {
                diagnosticView9()
            }
        }
        .sheet(isPresented: $showCamera) {
            CameraPicker(images: .constant([])) { captured in
                photoStore.imagesByKey[photoKey] = captured
            }
        }
    }
}


