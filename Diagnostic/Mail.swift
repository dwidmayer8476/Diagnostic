// Mail Composer

import SwiftUI

#if canImport(MessageUI)
import MessageUI
#endif

struct MailComposerSheet: View {
    var subject: String
    var messageBody: String
    var recipients: [String]?
    var attachmentURL: URL?
    var attachmentMimeType: String?
    var attachmentFileName: String?
    var carOwnerGmail: String
    @Environment(\.dismiss) private var dismiss
    @State private var isShowingMailComposer = false
    @State private var canSendMail = false

    var body: some View {
        
        Group {
            if canSendMail {
                MailComposeViewControllerWrapper(subject: subject,
                                                 messageBody: messageBody,
                                                 recipients: recipients ?? [carOwnerGmail, "jim.vanbladel@d214.org"],
                                                 attachmentURL: attachmentURL,
                                                 attachmentMimeType: attachmentMimeType,
                                                 attachmentFileName: attachmentFileName,
                                                 isPresented: $isShowingMailComposer,
                                                 dismissAction: { dismiss() })
                    .onAppear {
                        isShowingMailComposer = true
                    }
                    .sheet(isPresented: $isShowingMailComposer, onDismiss: {
                        dismiss()
                    }) {
                        MailComposeViewControllerWrapper(subject: subject,
                                                         messageBody: messageBody,
                                                         recipients: recipients ?? [carOwnerGmail, "jim.vanbladel@d214.org"],
                                                         attachmentURL: attachmentURL,
                                                         attachmentMimeType: attachmentMimeType,
                                                         attachmentFileName: attachmentFileName,
                                                         isPresented: $isShowingMailComposer,
                                                         dismissAction: { dismiss() })
                    }
            } else {
                MailUnavailableView()
                    .onAppear {
                        dismiss()
                    }
            }
        }
        .onAppear {
            #if canImport(MessageUI)
            canSendMail = MFMailComposeViewController.canSendMail()
            #else
            canSendMail = false
            #endif
        }
    }
}

#if canImport(MessageUI)
private struct MailComposeViewControllerWrapper: UIViewControllerRepresentable {
    var subject: String
    var messageBody: String
    var recipients: [String]?
    var attachmentURL: URL?
    var attachmentMimeType: String?
    var attachmentFileName: String?

    @Binding var isPresented: Bool
    var dismissAction: () -> Void

    func makeCoordinator() -> Coordinator {
        Coordinator(parent: self)
    }

    func makeUIViewController(context: Context) -> MFMailComposeViewController {
        let vc = MFMailComposeViewController()
        vc.mailComposeDelegate = context.coordinator
        vc.setSubject(subject)
        vc.setMessageBody(messageBody, isHTML: false)
        if let recipients = recipients {
            vc.setToRecipients(recipients)
        }
        if let url = attachmentURL,
           let mimeType = attachmentMimeType,
           let fileName = attachmentFileName,
           let data = try? Data(contentsOf: url) {
            vc.addAttachmentData(data, mimeType: mimeType, fileName: fileName)
        }
        return vc
    }

    func updateUIViewController(_ uiViewController: MFMailComposeViewController, context: Context) {}

    class Coordinator: NSObject, MFMailComposeViewControllerDelegate {
        let parent: MailComposeViewControllerWrapper

        init(parent: MailComposeViewControllerWrapper) {
            self.parent = parent
        }

        func mailComposeController(_ controller: MFMailComposeViewController, didFinishWith result: MFMailComposeResult, error: Error?) {
            parent.isPresented = false
            parent.dismissAction()
        }
    }
}
#endif

struct MailUnavailableView: View {
    @Environment(\.dismiss) var dismiss

    var body: some View {
        VStack(spacing: 20) {
            Text("Mail is unavailable")
                .font(.title)
                .multilineTextAlignment(.center)
            Text("Please configure a mail account or use a device with mail capabilities.")
                .multilineTextAlignment(.center)
                .foregroundColor(.secondary)
            Button("Dismiss") {
                dismiss()
            }
            .padding(.top)
        }
        .padding()
    }
}

// Mail Del & Mail Comp Control

import UIKit
import SwiftUI
import MessageUI

class MailDelegate: NSObject, MFMailComposeViewControllerDelegate {
    static let shared = MailDelegate()

    func mailComposeController(_ controller: MFMailComposeViewController,
                               didFinishWith result: MFMailComposeResult,
                               error: Error?) {
        controller.dismiss(animated: true)
    }
}

// MailRepComp

#if canImport(UIKit)
import UIKit
#endif
import SwiftUI
#if canImport(MessageUI)
import MessageUI
#endif

#if canImport(MessageUI)
@available(iOS 13.0, *)
final class AppMailComposerDelegate: NSObject, MFMailComposeViewControllerDelegate {
    static let shared = AppMailComposerDelegate()

    func mailComposeController(_ controller: MFMailComposeViewController,
                               didFinishWith result: MFMailComposeResult,
                               error: Error?) {
        controller.dismiss(animated: true)
    }
}


@available(iOS 13.0, *)
struct MailComposerRepresentable: UIViewControllerRepresentable {
    var subject: String
    var body: String
    var recipients: [String]
    var images: [UIImage]
    var isHTML: Bool = false

    func makeUIViewController(context: Context) -> MFMailComposeViewController {
        let vc = MFMailComposeViewController()
        vc.mailComposeDelegate = AppMailComposerDelegate.shared
        vc.setSubject(subject)
        vc.setMessageBody(body, isHTML: isHTML)
        if !recipients.isEmpty { vc.setToRecipients(recipients) }

   
        for (index, image) in images.enumerated() {
            if let data = image.jpegData(compressionQuality: 0.8) {
                vc.addAttachmentData(data, mimeType: "image/jpeg", fileName: "photo_\(index + 1).jpg")
            } else if let data = image.pngData() {
                vc.addAttachmentData(data, mimeType: "image/png", fileName: "photo_\(index + 1).png")
            }
        }
        return vc
    }

    func updateUIViewController(_ uiViewController: MFMailComposeViewController, context: Context) {

    }

    static func dismantleUIViewController(_ uiViewController: MFMailComposeViewController, coordinator: ()) {
        uiViewController.mailComposeDelegate = nil
    }
}


@available(iOS 15.0, *)
struct MailComposerPresenter: View {
    @Environment(\.dismiss) private var dismiss

    var subject: String
    var bodyText: String
    var recipients: [String] = []
    var images: [UIImage] = []
    var isHTML: Bool = false

    var body: some View {
        Group {
            if MFMailComposeViewController.canSendMail() {
                MailComposerRepresentable(subject: subject,
                                          body: bodyText,
                                          recipients: recipients,
                                          images: images,
                                          isHTML: isHTML)
            } else {

                VStack(spacing: 12) {
                    Image(systemName: "envelope.badge")
                        .imageScale(.large)
                        .foregroundColor(.secondary)
                    Text("Mail is not configured on this device.")
                        .multilineTextAlignment(.center)
                        .foregroundColor(.secondary)
                    Button("OK") {
                        dismiss()
                    }
                }
                .padding()
            }
        }
    }
}


@available(iOS 13.0, *)
extension AppMailComposerDelegate {
    static func present(subject: String,
                        body: String,
                        recipients: [String] = [],
                        images: [UIImage] = [],
                        isHTML: Bool = false) {
        guard MFMailComposeViewController.canSendMail() else { return }
        let composer = MFMailComposeViewController()
        composer.mailComposeDelegate = AppMailComposerDelegate.shared
        composer.setSubject(subject)
        composer.setMessageBody(body, isHTML: isHTML)
        if !recipients.isEmpty { composer.setToRecipients(recipients) }
        for (index, image) in images.enumerated() {
            if let data = image.jpegData(compressionQuality: 0.8) {
                composer.addAttachmentData(data, mimeType: "image/jpeg", fileName: "photo_\(index + 1).jpg")
            } else if let data = image.pngData() {
                composer.addAttachmentData(data, mimeType: "image/png", fileName: "photo_\(index + 1).png")
            }
        }

    
        if let windowScene = UIApplication.shared.connectedScenes
            .compactMap({ $0 as? UIWindowScene }).first,
           let window = windowScene.windows.first(where: { $0.isKeyWindow }),
           let root = window.rootViewController {
            root.present(composer, animated: true)
        }
    }
}
#endif


#if DEBUG && canImport(MessageUI)
@available(iOS 15.0, *)
struct MailComposerPresenter_Previews: PreviewProvider {
    static var previews: some View {
        MailComposerPresenter(subject: "Student Submission",
                              bodyText: "Here is the student's text.",
                              recipients: ["teacher@example.com"],
                              images: [],
                              isHTML: false)
    }
}
#endif

// MailView

import SwiftUI
import UIKit
import MessageUI

struct MailView {
    static func createMailController(pdfURL: URL) -> MFMailComposeViewController {
        let vc = MFMailComposeViewController()
        vc.mailComposeDelegate = MailDelegate.shared
        vc.setSubject("Vehicle Diagnostic Report")
        vc.setMessageBody("Please find the attached vehicle diagnostic report.", isHTML: false)

        if let data = try? Data(contentsOf: pdfURL) {
            vc.addAttachmentData(data, mimeType: "application/pdf", fileName: "DiagnosticReport.pdf")
        }
        return vc
    }
}

#if canImport(MessageUI)
struct MailComposerView: UIViewControllerRepresentable {
    let pdfURL: URL
    func makeUIViewController(context: Context) -> MFMailComposeViewController {
        let vc = MailView.createMailController(pdfURL: pdfURL)
        vc.mailComposeDelegate = context.coordinator
        return vc
    }

    func updateUIViewController(_ uiViewController: MFMailComposeViewController, context: Context) {}

    func makeCoordinator() -> Coordinator { Coordinator(self) }

    final class Coordinator: NSObject, MFMailComposeViewControllerDelegate {
        let parent: MailComposerView
        init(_ parent: MailComposerView) { self.parent = parent }
        func mailComposeController(_ controller: MFMailComposeViewController, didFinishWith result: MFMailComposeResult, error: Error?) {
            controller.dismiss(animated: true)
        }
    }
}
#endif

import PhotosUI
struct ImagePicker: UIViewControllerRepresentable {
    @Environment(\.dismiss) private var dismiss
    let sourceType: UIImagePickerController.SourceType
    let onImagePicked: (UIImage) -> Void

    func makeUIViewController(context: Context) -> UIImagePickerController {
        let picker = UIImagePickerController()
        picker.sourceType = sourceType
        picker.delegate = context.coordinator
        picker.allowsEditing = false
        return picker
    }

    func updateUIViewController(_ uiViewController: UIImagePickerController, context: Context) {}

    func makeCoordinator() -> Coordinator { Coordinator(self) }

    final class Coordinator: NSObject, UINavigationControllerDelegate, UIImagePickerControllerDelegate {
        let parent: ImagePicker
        init(_ parent: ImagePicker) { self.parent = parent }
        func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
            if let image = info[.originalImage] as? UIImage {
                parent.onImagePicked(image)
            }
            parent.dismiss()
        }
        func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
            parent.dismiss()
        }
    }
}

struct PDFWithPhotoGenerator {
    static func createTestPDF(vin: String, make: String, mileage: String, brakes: String, tires: String, engine: String, technician: String, photo: UIImage?) -> URL? {
        let pageRect = CGRect(x: 0, y: 0, width: 612, height: 792) // US Letter 8.5x11 at 72 dpi
        let renderer = UIGraphicsPDFRenderer(bounds: pageRect)
        let data = renderer.pdfData { ctx in
            ctx.beginPage()
            let margin: CGFloat = 24
            var y: CGFloat = margin

            func draw(text: String, font: UIFont = .systemFont(ofSize: 16, weight: .regular)) {
                let attrs: [NSAttributedString.Key: Any] = [
                    .font: font,
                    .foregroundColor: UIColor.label
                ]
                let attributed = NSAttributedString(string: text, attributes: attrs)
                let maxWidth = pageRect.width - margin * 2
                let rect = attributed.boundingRect(with: CGSize(width: maxWidth, height: .greatestFiniteMagnitude), options: [.usesLineFragmentOrigin, .usesFontLeading], context: nil)
                attributed.draw(in: CGRect(x: margin, y: y, width: maxWidth, height: ceil(rect.height)))
                y += ceil(rect.height) + 8
            }

            draw(text: "Vehicle Diagnostic Report", font: .systemFont(ofSize: 24, weight: .bold))
            y += 8
            draw(text: "VIN: \(vin)")
            draw(text: "Make: \(make)")
            draw(text: "Mileage: \(mileage)")
            draw(text: "Brakes Status: \(brakes)")
            draw(text: "Tires Status: \(tires)")
            draw(text: "Engine Status: \(engine)")
            draw(text: "Technician: \(technician)")

            if let image = photo {
                y += 8
                let maxWidth = pageRect.width - margin * 2
                let maxHeight = pageRect.height - y - margin
                let aspect = image.size.width / max(image.size.height, 1)
                var targetWidth = maxWidth
                var targetHeight = targetWidth / max(aspect, 0.0001)
                if targetHeight > maxHeight {
                    targetHeight = maxHeight
                    targetWidth = targetHeight * aspect
                }
                let x = margin + (maxWidth - targetWidth) / 2
                image.draw(in: CGRect(x: x, y: y, width: targetWidth, height: targetHeight))
            }
        }
        let tmpURL = FileManager.default.temporaryDirectory.appendingPathComponent("DiagnosticReport.pdf")
        do {
            try data.write(to: tmpURL)
            return tmpURL
        } catch {
            print("Failed to write PDF: \(error)")
            return nil
        }
    }
}

// SendMail

import SwiftUI
import PDFKit
import MessageUI


struct ReportView: View {
    var carInfo: carInfoClass? = nil
    var statusLinesOverride: [String]? = nil

    var notes: String
    var statuses: [String]
    var photos: [UIImage]

    
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

    init(carInfo: carInfoClass, stat: status, studentNotes: String, photos: [UIImage] = []) {
        self.carInfo = carInfo
        self.statusLinesOverride = ReportView.statusLines(from: stat)
        self.notes = studentNotes
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
                        // Support two patterns:
                        // 1) "Name: Status: Value" -> split on ": Status:" and render on two lines
                        // 2) "Name: Value" -> split on first ":" and render "Name" then "Status: Value"
                        if item.contains(": Status:") {
                            let parts = item.components(separatedBy: ": Status:")
                            if parts.count == 2 {
                                VStack(alignment: .leading, spacing: 2) {
                                    Text(parts[0])
                                    Text("Status: \(parts[1])")
                                        .foregroundStyle(.secondary)
                                }
                            } else {
                                Text(item)
                            }
                        } else if let firstColonRange = item.range(of: ":") {
                            let name = String(item[..<firstColonRange.lowerBound]).trimmingCharacters(in: .whitespaces)
                            let value = String(item[firstColonRange.upperBound...]).trimmingCharacters(in: .whitespaces)
                            VStack(alignment: .leading, spacing: 2) {
                                Text(name)
                                Text("Status: \(value)")
                                    .foregroundStyle(.secondary)
                            }
                        } else {
                            Text(item)
                        }
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
    // Measure the SwiftUI view to determine content size within the printable width
    let printableWidth = pageSize.width - margins * 2
    // Use a hosting controller to size the content
    let host = UIHostingController(rootView: view)
    host.view.backgroundColor = .systemBackground
    // Constrain the width to printableWidth and ask Auto Layout for fitting height
    host.view.translatesAutoresizingMaskIntoConstraints = false
    let targetSize = CGSize(width: printableWidth, height: UIView.layoutFittingCompressedSize.height)

    // Create a container to help systemLayoutSizeFitting resolve width constraints
    let container = UIView(frame: CGRect(origin: .zero, size: CGSize(width: printableWidth, height: 10)))
    container.addSubview(host.view)
    NSLayoutConstraint.activate([
        host.view.leadingAnchor.constraint(equalTo: container.leadingAnchor),
        host.view.trailingAnchor.constraint(equalTo: container.trailingAnchor),
        host.view.topAnchor.constraint(equalTo: container.topAnchor)
    ])
    // Ask for the best fitting size at the constrained width
    let fittingSize = host.view.systemLayoutSizeFitting(
        targetSize,
        withHorizontalFittingPriority: .required,
        verticalFittingPriority: .fittingSizeLevel
    )

    // Determine total content height and pagination parameters
    let contentHeight = max(ceil(fittingSize.height), 1)
    let printableHeight = pageSize.height - margins * 2

    // Prepare PDF renderer
    let bounds = CGRect(origin: .zero, size: pageSize)
    let renderer = UIGraphicsPDFRenderer(bounds: bounds)

    let data = renderer.pdfData { ctx in
        // Render across as many pages as needed by vertically offsetting the layer
        var yOffset: CGFloat = 0
        let totalPages = max(Int(ceil(contentHeight / printableHeight)), 1)

        for _ in 0..<totalPages {
            ctx.beginPage()
            let cg = ctx.cgContext
            cg.saveGState()
            // Translate into printable area and apply page offset
            cg.translateBy(x: margins, y: margins - yOffset)

            // Ensure the host view has the full content frame so we can offset-render
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

