
import SwiftUI

struct diagnosticView23: View {
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
    @State private var notes: String = ""
    private let photoKey = "page23"
    
    private var selectedColor: String {
        if status.red { return "Red" }
        if status.yellow { return "Yellow" }
        if status.green { return "Green" }
        return "None"
    }
    
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
            
            Text("Timing Belt")
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
                }
            }
            Text("status: \(selectedColor)")
            
            TextField("Enter Notes", text: $notes)
                .frame(width: 300, height: 50)
                .textFieldStyle(.roundedBorder)
            
            Button("Confirm?") {
                let message = """
                page23: status=\(selectedColor)
                notes: \(notes)
                """
                
                printStore.log(message,for: "TimingBelt")
            }
            .font(.largeTitle)
            .foregroundStyle(.red)
            .buttonStyle(.bordered)
            .buttonBorderShape(.roundedRectangle)
            .controlSize(.large)
            
            Button("Take Photo for Page 23") {
                showCamera = true
            }.buttonStyle(.bordered)
            
            NavigationLink("Next Page") {
                diagnosticView24()
            }
            
            NavigationLink("Previous Page") {
                diagnosticView22()
            }
        }
        .sheet(isPresented: $showCamera) {
            CameraPicker(images: .constant([]), onConfirm:  { captured in
                photoStore.imagesByKey[photoKey] = captured
            })
        }
    }
}







