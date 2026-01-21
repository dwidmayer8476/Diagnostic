
import SwiftUI
struct PrintSummaryView: View {
    @EnvironmentObject var printStore: PrintStore

    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 12) {
                Text("Summary")
                    .font(.largeTitle)
                    .padding(.bottom)

                ForEach(printStore.messages.indices, id: \.self) { index in
                    Text(printStore.messages[index])
                        .padding()
                        .frame(maxWidth: .infinity, alignment: .leading)
                        .background(Color.gray.opacity(0.15))
                        .cornerRadius(10)
                }
            }
            .padding()
        }
    }
}

