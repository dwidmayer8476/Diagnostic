import SwiftUI
struct PrintSummaryView: View {
    @EnvironmentObject var printStore: PrintStore
    @EnvironmentObject var photoStore: PhotoStore
    
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
        NavigationStack {
            NavigationLink("Send PDF") {
                // Use the collected messages as status lines, empty notes by default, and any photos stored for summary if available
                let statuses = printStore.messages
                let notes = ""
                let photos = photoStore.imagesByKey.values.flatMap { $0 }
                ReportView(notes: notes, statuses: statuses, photos: photos)
            }
        }
    }
}

