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


