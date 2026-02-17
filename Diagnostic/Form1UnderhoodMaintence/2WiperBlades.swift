import SwiftUI
import UIKit

struct diagnosticView2: View {
    @EnvironmentObject var printStore: PrintStore
    @State private var showCamera = false
    @State private var isShowingReview = false
    @State private var pendingImage: UIImage?
    @State private var savedImage: UIImage?
    @State private var notes: String = ""
    
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
            
            Image("Rules")
                .resizable()
                .scaledToFit()
                .padding()
            
            Text("Under Hood / Maintenance Service")
                .font(.largeTitle)
                .foregroundStyle(.red)
                .padding(10)
            
            Text("Wiper Blades")
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
                page2: status=\(selectedColor)
                Notes: \(notes)
                """
                
                printStore.log(message,for: "WiperBlades")
            }
            .font(.largeTitle)
            .foregroundStyle(.red)
            .buttonStyle(.bordered)
            .buttonBorderShape(.roundedRectangle)
            .controlSize(.large)
            
            if let savedImage {
                Image(uiImage: savedImage)
                    .resizable()
                    .scaledToFit()
                    .frame(height: 120)
                    .clipShape(RoundedRectangle(cornerRadius: 8))
            }
            
            Button("Take Photo for Page 2") {
                showCamera = true
            }
            .buttonStyle(.bordered)
            
            NavigationLink("Next Page") {
                diagnosticView3()
            }
            NavigationLink("Previous Page") {
                diagnosticView1()
            }

        }
        .sheet(isPresented: $showCamera) {
            CameraPicker(images: .constant([]), onCapture: { captured in
                pendingImage = captured
                isShowingReview = true
            })
        }
        .sheet(isPresented: $isShowingReview) {
            ReviewPhotoActionSheet(
                image: pendingImage,
                onUse: {
                    if let img = pendingImage {
                        savedImage = img
                    }
                    pendingImage = nil
                    isShowingReview = false
                },
                onRetake: {
                    pendingImage = nil
                    isShowingReview = false
                    showCamera = true
                }
            )
        }
    }
}

