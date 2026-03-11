import SwiftUI

struct PrintSummaryView: View {
    @EnvironmentObject var printStore: PrintStore
    @EnvironmentObject var photoStore: PhotoStore

    var body: some View {
        NavigationStack {
            ScrollView {
                VStack(alignment: .leading, spacing: 12) {
                    Text("Summary")
                        .font(.largeTitle)
                        .padding(.bottom)

                    if printStore.messages.isEmpty {
                        Text("No items to summarize yet.")
                            .foregroundStyle(.secondary)
                            .padding()
                            .frame(maxWidth: .infinity, alignment: .leading)
                            .background(Color.gray.opacity(0.1))
                            .cornerRadius(10)
                    } else {
                        ForEach(printStore.messages.indices, id: \.self) { index in
                            Text(printStore.messages[index])
                                .padding()
                                .frame(maxWidth: .infinity, alignment: .leading)
                                .background(Color.gray.opacity(0.15))
                                .cornerRadius(10)
                        }
                    }
                }
                .padding()
            }
            .navigationTitle("Summary")
            .toolbar {
                ToolbarItem(placement: .topBarTrailing) {
                    NavigationLink {
                        let statuses = printStore.messages
                        let notes = ""
                        let photos = photoStore.imagesByKey.values.compactMap { $0 }
                        ReportView(notes: notes, statuses: statuses, photos: photos)
                    } label: {
                        Label("Send PDF", systemImage: "paperplane")
                    }
                }
            }
        }
    }
}

