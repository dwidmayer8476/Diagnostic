import SwiftUI
import PDFKit
import MessageUI


struct ReportView: View {
    var carInfo: carInfoClass? = nil
    var statusLinesOverride: [String]? = nil

    var notes: String
    var statuses: [String]
    var photos: [UIImage]

    // Convenience initializer used by previews and SendTheReportView
    init(notes: String, statuses: [String], photos: [UIImage] = []) {
        self.carInfo = nil
        self.statusLinesOverride = nil
        self.notes = notes
        self.statuses = statuses
        self.photos = photos
    }

    @State private var pdfData: Data? = nil
    @State private var showMail = false
    @State private var showShare = false

    init(carInfo: carInfoClass, stat: status, studentNotes: status.studentNotes, photos: [UIImage] = []) {
        self.carInfo = carInfo
        self.statusLinesOverride = ReportView.statusLines(from: stat)
        self.notes = studentNotes.notes
        self.statuses = self.statusLinesOverride ?? []
        self.photos = photos
    }

    static func statusLines(from s: status) -> [String] {
        var items: [String] = []
        if s.red { items.append("Red: Issues detected") }
        if s.yellow { items.append("Yellow: Warnings present") }
        if s.green { items.append("Green: All checks passed") }
        return items
    }

    var body: some View {
        reportContent
            .toolbar {
                ToolbarItem(placement: .topBarTrailing) {
                    Button {
                        if let data = makePDF(from: reportContent) {
                            pdfData = data
                            if MFMailComposeViewController.canSendMail() {
                                showMail = true
                            } else {
                                showShare = true
                            }
                        }
                    } label: {
                        Label("Send", systemImage: "envelope")
                    }
                }
            }
            .sheet(isPresented: $showMail) {
                if let data = pdfData {
                    MailComposer(
                        subject: "Diagnostic Report",
                        recipients: [],
                        body: "Please find the diagnostic report attached.",
                        attachment: (data, "application/pdf", "DiagnosticReport.pdf")
                    )
                }
            }
            .sheet(isPresented: $showShare) {
                if let data = pdfData { ShareSheet(items: [data]) }
            }
    }

    private var reportContent: some View {
        VStack(alignment: .leading, spacing: 12) {
            Text("Diagnostic Report").font(.title).bold()
            Text(Date().formatted(date: .abbreviated, time: .shortened))
                .font(.subheadline).foregroundStyle(.secondary)
            Divider()

            if let info = carInfo {
                Text("Vehicle Info").font(.headline)
                VStack(alignment: .leading, spacing: 4) {
                    Text("VIN: \(info.carVin)")
                    Text("Make: \(info.make)")
                    Text("Year: \(info.year)")
                    Text("Owner: \(info.carOwner)")
                    Text("Gmail: \(info.carGmail)")
                }
                Divider()
            }

            Text("Summary").font(.headline)
            VStack(alignment: .leading, spacing: 6) {
                let summaryStatuses = statusLinesOverride ?? statuses
                if summaryStatuses.isEmpty {
                    Text("No statuses provided.").foregroundStyle(.secondary)
                } else {
                    ForEach(summaryStatuses, id: \.self) { item in
                        Text("• \(item)")
                    }
                }
            }

            Text("Notes").font(.headline).padding(.top, 8)
            if notes.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty {
                Text("No notes provided.").foregroundStyle(.secondary)
            } else {
                Text(notes)
            }

            if !photos.isEmpty {
                Text("Photos").font(.headline).padding(.top, 8)
                let columns = [GridItem(.flexible()), GridItem(.flexible()), GridItem(.flexible())]
                LazyVGrid(columns: columns, spacing: 8) {
                    ForEach(Array(photos.enumerated()), id: \.offset) { _, img in
                        Image(uiImage: img)
                            .resizable()
                            .scaledToFit()
                            .frame(height: 120)
                            .clipped()
                            .cornerRadius(6)
                            .overlay(RoundedRectangle(cornerRadius: 6).stroke(Color.secondary.opacity(0.2)))
                    }
                }
            }

            Spacer()
        }
        .padding()
        .background(Color(.systemBackground))
    }
}

func makePDF<Content: View>(from view: Content, pageSize: CGSize = .init(width: 612, height: 792), margins: CGFloat = 24) -> Data? {
    #if canImport(UIKit)
    let bounds = CGRect(origin: .zero, size: pageSize)
    let renderer = UIGraphicsPDFRenderer(bounds: bounds)
    let data = renderer.pdfData { ctx in
        ctx.beginPage()
        let cg = ctx.cgContext
        cg.saveGState()
        cg.translateBy(x: margins, y: margins)
        let contentSize = CGSize(width: pageSize.width - margins*2, height: pageSize.height - margins*2)
        let host = UIHostingController(rootView: view)
        host.view.backgroundColor = .systemBackground
        host.view.frame = CGRect(origin: .zero, size: contentSize)
        host.view.layoutIfNeeded()
        host.view.layer.render(in: cg)
        cg.restoreGState()
    }
    return data
    #else
    return nil
    #endif
}


struct MailComposer: UIViewControllerRepresentable {
    var subject: String
    var recipients: [String] = []
    var body: String = ""
    var attachment: (data: Data, mimeType: String, fileName: String)? = nil

    class Coordinator: NSObject, MFMailComposeViewControllerDelegate {
        func mailComposeController(_ controller: MFMailComposeViewController, didFinishWith result: MFMailComposeResult, error: Error?) {
            controller.dismiss(animated: true)
        }
    }
    func makeCoordinator() -> Coordinator { Coordinator() }

    func makeUIViewController(context: Context) -> MFMailComposeViewController {
        let vc = MFMailComposeViewController()
        vc.mailComposeDelegate = context.coordinator
        vc.setSubject(subject)
        if !recipients.isEmpty { vc.setToRecipients(recipients) }
        vc.setMessageBody(body, isHTML: false)
        if let a = attachment { vc.addAttachmentData(a.data, mimeType: a.mimeType, fileName: a.fileName) }
        return vc
    }
    func updateUIViewController(_ uiViewController: MFMailComposeViewController, context: Context) {}
}

struct ShareSheet: UIViewControllerRepresentable {
    let items: [Any]
    func makeUIViewController(context: Context) -> UIActivityViewController {
        UIActivityViewController(activityItems: items, applicationActivities: nil)
    }
    func updateUIViewController(_ uiViewController: UIActivityViewController, context: Context) {}
}


struct PDFPreview: UIViewRepresentable {
    let data: Data
    func makeUIView(context: Context) -> PDFView { let v = PDFView(); v.autoScales = true; return v }
    func updateUIView(_ uiView: PDFView, context: Context) { uiView.document = PDFDocument(data: data) }
}

struct SendTheReportView: View {
    @State private var pdfData: Data?
    @State private var showMail = false
    @State private var showShare = false

    let sampleStatuses = ["Battery: OK", "Storage: Low", "Network: Unstable"]
    let sampleNotes = "User noted intermittent lag when launching app."
    let samplePhotos: [UIImage] = []

    var body: some View {
        VStack(spacing: 16) {
            Group {
                if let data = pdfData { PDFPreview(data: data).frame(height: 360).clipShape(RoundedRectangle(cornerRadius: 10)) }
                else { Text("No PDF yet. Tap Generate.").foregroundStyle(.secondary).frame(height: 360).frame(maxWidth: .infinity).background(Color(.secondarySystemBackground)).clipShape(RoundedRectangle(cornerRadius: 10)) }
            }.padding(.horizontal)

            HStack(spacing: 12) {
                Button {
                    pdfData = makePDF(from: ReportView(notes: sampleNotes, statuses: sampleStatuses, photos: samplePhotos))
                } label: { Label("Generate PDF", systemImage: "doc.fill") }
                .buttonStyle(.borderedProminent)

                Button {
                    if MFMailComposeViewController.canSendMail() { showMail = true } else { showShare = true }
                } label: { Label("Send via Mail", systemImage: "envelope") }
                .buttonStyle(.bordered)
                .disabled(pdfData == nil)
            }
            .padding(.horizontal)
            Spacer()
        }
        .navigationTitle("Send Report")
        .sheet(isPresented: $showMail) {
            if let data = pdfData {
                MailComposer(
                    subject: "Diagnostic Report",
                    recipients: [],
                    body: "Please find the diagnostic report attached.",
                    attachment: (data, "application/pdf", "DiagnosticReport.pdf")
                )
            }
        }
        .sheet(isPresented: $showShare) {
            if let data = pdfData { ShareSheet(items: [data]) }
        }
    }
}

#Preview {
    NavigationStack { SendTheReportView() }
}

