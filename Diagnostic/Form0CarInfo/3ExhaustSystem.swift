import SwiftUI
import UIKit

// Exhaust System - Page 25
struct diagnosticView25: View {
    var body: some View {
        DiagnosticPage(
            category: .exhaust,
            sectionTitle: "Exhaust System",
            logKey: "ExhaustSystem",
            logLabel: "ExhaustSystem",
            photoKey: "page25",
            photoButtonTitle: "Take Photo for Page 25",
            next: diagnosticView26(),
            previous: diagnosticView24()
        )
    }
}


