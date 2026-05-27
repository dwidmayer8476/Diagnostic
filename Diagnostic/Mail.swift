import SwiftUI
import UIKit
#if canImport(MessageUI)
import MessageUI
#endif
import PDFKit

// This shows the Apple Mail screen. You can set a subject, message,
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
// If Mail is not set up on the device, itshares the PDF
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


// Minimal, lower-level: create a single blank PDF page as Data
func makeBlankPDF(pageSize: CGSize = CGSize(width: 612, height: 792)) -> Data? {
#if canImport(UIKit)
    let bounds = CGRect(origin: .zero, size: pageSize)
    let renderer = UIGraphicsPDFRenderer(bounds: bounds)
    let data = renderer.pdfData { ctx in
        ctx.beginPage()
        // Intentionally draw nothing: a blank page
        // If you want a border to visualize, uncomment below:
        // UIColor.black.setStroke()
        // UIBezierPath(rect: bounds.insetBy(dx: 1, dy: 1)).stroke()
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
    var carInfo: CarReport? = nil

    init(notes: String, statuses: [String], photos: [UIImage] = []) {
        self.notes = notes
        self.statuses = statuses
        self.photos = photos
    }
    
    var body: some View {
        content
    }

    // What the report looks like on screen (also what we turn into a PDF)
    private var content: some View {
        NavigationStack {
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
                NavigationLink {
                    ContentView()
                } label: {
                    Text("Go Back To Start")
                        .font(.largeTitle)
                    
                    Spacer()
                }
            }
            .padding()
            .background(Color(.systemBackground))
        }
    }
} // <-- Close ReportView

// demo
struct SendTheReportView: View {
    @State private var pdfData: Data?
    @State private var showMail = false
    @State private var showShare = false

    var body: some View {
        VStack(spacing: 16) {
            Button {
#if canImport(MessageUI)
                if MFMailComposeViewController.canSendMail() {
                    showMail = true
                } else {
                    Text("No PDF yet. Tap Generate.")
                        .foregroundStyle(.secondary)
                        .frame(height: 120)
                        .frame(maxWidth: .infinity)
                        .background(Color(.secondarySystemBackground))
                        .clipShape(RoundedRectangle(cornerRadius: 10))
                }
            }
            .padding(.horizontal)

            HStack(spacing: 12) {
                Button {
                    pdfData = PDFGenerator.makeReportPDFData(
                        vin: "TESTVIN1234567890",
                        make: "Test Make",
                        mileage: "123,456",
                        brakes: "OK",
                        tires: "OK",
                        engine: "OK",
                        technician: "Technician"
                    )
                    if let d = pdfData { print("Generated PDF bytes: \(d.count)") }
                } label: { Label("Generate PDF", systemImage: "doc.fill") }
                .buttonStyle(.borderedProminent)

                Button {
#if canImport(MessageUI)
                    if MFMailComposeViewController.canSendMail() {
                        if pdfData == nil {
                            pdfData = PDFGenerator.makeReportPDFData(
                                vin: "TESTVIN1234567890",
                                make: "Test Make",
                                mileage: "123,456",
                                brakes: "OK",
                                tires: "OK",
                                engine: "OK",
                                technician: "Technician"
                            )
                        }
                        showMail = (pdfData != nil)
                    } else {
                        showShare = true
                    }
#else
                    showShare = true
                }
#else
                showShare = true
#endif
            } label: {
                Label("Send PDF", systemImage: "envelope")
            }
            .buttonStyle(.borderedProminent)
            .onAppear {
                // Prepare a minimal blank PDF once
                if pdfData == nil {
                    pdfData = makeBlankPDF()
                }
            }
            .disabled(pdfData == nil)
        }
        .navigationTitle("Send Report")
        .sheet(isPresented: $showMail) {
            if let data = pdfData {
                SimpleMailComposer(
                    subject: "PDF",
                    message: "",
                    recipients: [],
                    attachment: (data, "application/pdf", "Document.pdf")
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
