

import SwiftUI
import UIKit
#if canImport(MessageUI)
import MessageUI
#endif
import PDFKit

/// This shows the Apple Mail screen. You can set a subject, message,
// recipients, and add one optional attachment.
struct SimpleMailComposer: UIViewControllerRepresentable {
    var subject: String
    var message: String
    var recipients: [String] = []
    // Optional attachment: data + type + file name
    var attachment: (data: Data, mimeType: String, fileName: String)? = nil

    class Coordinator: NSObject, MFMailComposeViewControllerDelegate {
        func mailComposeController(_ controller: MFMailComposeViewController,
                                   didFinishWith result: MFMailComposeResult,
                                   error: Error?) {
            controller.dismiss(animated: true)
        }
    }

    func makeCoordinator() -> Coordinator { Coordinator() }

    func makeUIViewController(context: Context) -> MFMailComposeViewController {
        let vc = MFMailComposeViewController()
        vc.mailComposeDelegate = context.coordinator
        vc.setSubject(subject)
        vc.setMessageBody(message, isHTML: false)
        if !recipients.isEmpty { vc.setToRecipients(recipients) }
        if let a = attachment {
            vc.addAttachmentData(a.data, mimeType: a.mimeType, fileName: a.fileName)
        }
        return vc
    }

    func updateUIViewController(_ uiViewController: MFMailComposeViewController, context: Context) {}
}

// Share Sheet
// If Mail is not set up on the device, we can still share the PDF
// through other apps (Files, AirDrop, etc.).
struct SimpleShareSheet: UIViewControllerRepresentable {
    let items: [Any]
    func makeUIViewController(context: Context) -> UIActivityViewController {
        UIActivityViewController(activityItems: items, applicationActivities: nil)
    }
    func updateUIViewController(_ uiViewController: UIActivityViewController, context: Context) {}
}

//
struct PDFPreviewView: UIViewRepresentable {
    let data: Data
    func makeUIView(context: Context) -> PDFView {
        let v = PDFView()
        v.autoScales = true
        v.document = PDFDocument(data: data)
        return v
    }
    func updateUIView(_ uiView: PDFView, context: Context) {
        uiView.document = PDFDocument(data: data)
    }
}


// This turns a SwiftUI view into a PDF file (as Data).
func makePDF<Content: View>(from view: Content,
                            pageSize: CGSize = .init(width: 612, height: 792), // US Letter
                            margins: CGFloat = 24) -> Data? {
#if canImport(UIKit)
    let printableWidth = pageSize.width - margins * 2

    // Put the SwiftUI view inside a hosting controller so we can lay it out
    let host = UIHostingController(rootView: view)
    host.view.backgroundColor = .systemBackground
    host.view.translatesAutoresizingMaskIntoConstraints = false

    // Create a container to help size the view at the given width
    let container = UIView(frame: CGRect(origin: .zero, size: CGSize(width: printableWidth, height: 10)))
    container.addSubview(host.view)
    NSLayoutConstraint.activate([
        host.view.leadingAnchor.constraint(equalTo: container.leadingAnchor),
        host.view.trailingAnchor.constraint(equalTo: container.trailingAnchor),
        host.view.topAnchor.constraint(equalTo: container.topAnchor)
    ])

    let targetSize = CGSize(width: printableWidth, height: UIView.layoutFittingCompressedSize.height)
    let fittingSize = host.view.systemLayoutSizeFitting(
        targetSize,
        withHorizontalFittingPriority: .required,
        verticalFittingPriority: .fittingSizeLevel
    )

    let contentHeight = max(ceil(fittingSize.height), 1)
    let printableHeight = pageSize.height - margins * 2

    let bounds = CGRect(origin: .zero, size: pageSize)
    let renderer = UIGraphicsPDFRenderer(bounds: bounds)

    let data = renderer.pdfData { ctx in
        var yOffset: CGFloat = 0
        let totalPages = max(Int(ceil(contentHeight / printableHeight)), 1)

        for _ in 0..<totalPages {
            ctx.beginPage()
            let cg = ctx.cgContext
            cg.saveGState()
            cg.translateBy(x: margins, y: margins - yOffset)

            host.view.frame = CGRect(origin: .zero, size: CGSize(width: printableWidth, height: contentHeight))
            host.view.layoutIfNeeded()
            host.view.layer.render(in: cg)

            cg.restoreGState()
            yOffset += printableHeight
        }
    }
    return data
#else
    return nil
#endif
}


struct ReportView: View {
    // Basic info for the report
    var notes: String
    var statuses: [String]
    var photos: [UIImage]

    // Optional car info (can be nil)
    var carInfo: carInfoClass? = nil

    init(notes: String, statuses: [String], photos: [UIImage] = []) {
        self.notes = notes
        self.statuses = statuses
        self.photos = photos
    }

    @State private var pdfData: Data? = nil
    @State private var showMail = false
    @State private var showShare = false

    var body: some View {
        content
            .toolbar {
                ToolbarItem(placement: .topBarTrailing) {
                    Button {
                        if let data = makePDF(from: content) {
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
                        Label("Send", systemImage: "envelope")
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
                if let data = pdfData { SimpleShareSheet(items: [data]) }
            }
    }

    // What the report looks like on screen (also what we turn into a PDF)
    private var content: some View {
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
            if statuses.isEmpty {
                Text("No statuses provided.").foregroundStyle(.secondary)
            } else {
                VStack(alignment: .leading, spacing: 6) {
                    ForEach(statuses, id: \.self) { item in
                        Text("• \(item)")
                    }
                }
            }

            Text("Notes").font(.headline).padding(.top, 8)
            if notes.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty {
                Text("No notes provided.").foregroundStyle(.secondary)
            } else {
                VStack(alignment: .leading, spacing: 4) {
                    ForEach(notes
                        .components(separatedBy: CharacterSet.newlines)
                        .map { $0.trimmingCharacters(in: .whitespacesAndNewlines) }
                        .filter { !$0.isEmpty }, id: \.self) { line in
                        Text("• \(line)")
                    }
                }
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

// demo
struct SendTheReportView: View {
    @State private var pdfData: Data?
    @State private var showMail = false
    @State private var showShare = false

    let exampleStatuses = ["Battery: OK", "Storage: Low", "Network: Unstable"]
    let exampleNotes = "User noticed slow launches sometimes."
    let examplePhotos: [UIImage] = []

    var body: some View {
        VStack(spacing: 16) {
            Group {
                if let data = pdfData {
                    PDFPreviewView(data: data)
                        .frame(height: 360)
                        .clipShape(RoundedRectangle(cornerRadius: 10))
                } else {
                    Text("No PDF yet. Tap Generate.")
                        .foregroundStyle(.secondary)
                        .frame(height: 360)
                        .frame(maxWidth: .infinity)
                        .background(Color(.secondarySystemBackground))
                        .clipShape(RoundedRectangle(cornerRadius: 10))
                }
            }
            .padding(.horizontal)

            HStack(spacing: 12) {
                Button {
                    pdfData = makePDF(from: ReportView(notes: exampleNotes, statuses: exampleStatuses, photos: examplePhotos))
                } label: { Label("Generate PDF", systemImage: "doc.fill") }
                .buttonStyle(.borderedProminent)

                Button {
#if canImport(MessageUI)
                    if MFMailComposeViewController.canSendMail() { showMail = true } else { showShare = true }
#else
                    showShare = true
#endif
                } label: { Label("Send via Mail", systemImage: "envelope") }
                .buttonStyle(.bordered)
                .disabled(pdfData == nil)
            }
            .padding(.horizontal)
            Spacer()
            NavigationStack{
                NavigationLink {
                    ContentView()
                } label: {
                    Text("Finished")
                        .font(.largeTitle)
                        .fontWeight(.bold)
                        .frame(maxWidth: 650)
                        .frame(maxHeight: 100)
                        .padding(.vertical, 18)
                }
            }
        }
        .navigationTitle("Send Report")
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
            if let data = pdfData { SimpleShareSheet(items: [data]) }
        }
    }
}

#Preview {
    NavigationStack { SendTheReportView() }
}


