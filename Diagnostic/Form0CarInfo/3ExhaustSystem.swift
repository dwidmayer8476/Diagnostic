import SwiftUI
import UIKit

// Transmission Fluid - Page 25
struct diagnosticView25: View {
    var body: some View {
        DiagnosticPage(
            sectionTitle: "Transmission Fluid",
            logKey: "TransmissionFluid",
            logLabel: "TransmissionFluid",
            photoKey: "page24",
            photoButtonTitle: "Take Photo for Page 24",
            next: diagnosticView26(),
            previous: diagnosticView25()
        )
    }
}


