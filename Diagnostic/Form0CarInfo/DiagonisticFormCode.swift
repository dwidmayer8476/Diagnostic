import SwiftUI
import UIKit

enum DiagnosticCategory {
    case underHood
    case exhaust
    case steeringSuspension

    var headerTitle: String {
        switch self {
        case .underHood: return "Under Hood/Maintenance Service"
        case .exhaust: return "Exhaust System"
        case .steeringSuspension: return "Steering & Suspension"
        }
    }
}

struct DiagnosticPage<Next: View, Previous: View>: View {
    @EnvironmentObject var photoStore: PhotoStore
    @EnvironmentObject var printStore: PrintStore

    let category: DiagnosticCategory
    let sectionTitle: String
    let logKey: String
    let logLabel: String
    let photoKey: String?
    let photoButtonTitle: String?
    let next: Next
    let previous: Previous

    
    struct DiagnosticStatus: CustomStringConvertible {
        var red: Bool
        var yellow: Bool
        var green: Bool
        var description: String { "DiagnosticStatus(red: \(red), yellow: \(yellow), green: \(green))" }
    }

    @State private var showCamera = false
    @State private var notes: String = ""
    @State private var status: DiagnosticColor = .none

    var body: some View {
        VStack(spacing: 20) {
            Image("Rules")
                .resizable()
                .scaledToFit()
                .padding()

            Text(category.headerTitle)
                .font(.largeTitle)
                .foregroundStyle(.red)
                .padding(10)

            Text(sectionTitle)
                .font(.largeTitle)

            StatusPicker(selection: $status)

            Text("Status: \(status.rawValue)")

            TextField("Enter Notes", text: $notes)
                .frame(width: 300, height: 50)
                .textFieldStyle(.roundedBorder)

            Button("Confirm?") {
                let message = """
                \(logLabel): Status: \(status.rawValue)
                Notes: \(notes)
                """
                printStore.log(message, for: logKey)
            }
            .font(.largeTitle)
            .foregroundStyle(.red)
            .buttonStyle(.bordered)
            .buttonBorderShape(.roundedRectangle)
            .controlSize(.large)

            if let photoKey, let photoButtonTitle {
                Button(photoButtonTitle) {
                    showCamera = true
                }
                .buttonStyle(.bordered)
                .sheet(isPresented: $showCamera) {
                    CameraPicker(images: .constant([]), onConfirm: { captured in
                        photoStore.imagesByKey[photoKey] = captured
                    })
                }
            }

            NavigationLink("Next Page") { next }
            NavigationLink("Previous Page") { previous }
        }
    }
}

