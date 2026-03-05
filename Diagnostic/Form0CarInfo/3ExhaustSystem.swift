import SwiftUI
import UIKit

// Exhaust System - Page 25
struct diagnosticView25: View {
    var body: some View {
        DiagnosticPage(
            category: .exhaust,
            sectionTitle: "Exhaust System",
            logKey: "Exhaust System",
            logLabel: "Exhaust System",
            photoKey: "page25",
            photoButtonTitle: "Take Photo for Exhaust System",
            next: diagnosticView26(),
            previous: diagnosticView24()
        )
    }
}
