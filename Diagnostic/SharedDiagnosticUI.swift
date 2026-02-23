import SwiftUI

public enum DiagnosticColor: String, CaseIterable {
    case none = "None"
    case green = "Green"
    case yellow = "Yellow"
    case red = "Red"
}

public struct StatusPicker: View {
    @Binding var selection: DiagnosticColor

    public init(selection: Binding<DiagnosticColor>) {
        self._selection = selection
    }

    public var body: some View {
        HStack(spacing: 25) {
            Button("Green") { selection = .green }
            Button("Yellow") { selection = .yellow }
            Button("Red") { selection = .red }
        }
    }
}
