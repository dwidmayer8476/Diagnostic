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

