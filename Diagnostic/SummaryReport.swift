import SwiftUI
import MessageUI

struct PrintSummaryView: View {
    @EnvironmentObject var printStore: PrintStore
    @EnvironmentObject var photoStore: PhotoStore

    @State private var pdfData: Data?
    @State private var showMail = false
    @State private var showShare = false

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

                        // Photos section
                        if !photoStore.imagesByKey.isEmpty {
                            Text("Photos")
                                .font(.title2)
                                .padding(.top, 8)

                            ScrollView(.horizontal, showsIndicators: false) {
                                HStack(spacing: 12) {
                                    ForEach(Array(photoStore.imagesByKey.values.enumerated()), id: \.offset) { _, img in
                                        Image(uiImage: img)
                                            .resizable()
                                            .scaledToFit()
                                            .frame(width: 200, height: 200)
                                            .clipShape(RoundedRectangle(cornerRadius: 12))
                                            .padding(4)
                                            .background(Color.gray.opacity(0.1))
                                            .cornerRadius(14)
                                    }
                                }
                                .padding(.horizontal, 2)
                            }
                            .frame(height: 220)
                        }
                    }
                }
                .padding()
            }
            .navigationTitle("Summary")
            .toolbar {
                ToolbarItem(placement: .topBarTrailing) {
                    Button {
                        let statuses = printStore.messages
                        let photos: [UIImage] = Array(photoStore.imagesByKey.values)
                        // Notes are separate from statuses; provide empty or fetch from your store
                        let notes = ""
                        if let data = makePDF(from: ReportView(notes: notes, statuses: statuses, photos: photos)) {
                            pdfData = data
#if canImport(MessageUI)
                            if MFMailComposeViewController.canSendMail() {
                                showMail = true
                            } else {
                                showShare = true
                            }
#else
                            showShare = true
#endif
                        }
                    } label: {
                        Label("Send PDF", systemImage: "paperplane")
                    }
                }
            }
            .sheet(isPresented: $showMail) {
                if let data = pdfData {
                    SimpleMailComposer(
                        subject: "Diagnostic Report",
                        message: "Please find the diagnostic report attached.",
                        recipients: [],
                        attachment: (data, "application/pdf", "DiagnosticReport.pdf")
                    )
                }
            }
            .sheet(isPresented: $showShare) {
                if let data = pdfData {
                    SimpleShareSheet(items: [data])
                }
            }
        }
    }
}

