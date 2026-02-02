//
//  MailComposer.swift
//  Diagnostic
//
//  Created by Dylan J. Widmayer on 2/2/26.
//
import SwiftUI

#if canImport(MessageUI)
import MessageUI
#endif

struct MailComposerView: View {
    var subject: String
    var body: String
    var recipients: [String]?
    var attachmentURL: URL?
    var attachmentMimeType: String?
    var attachmentFileName: String?

    @Environment(\.dismiss) private var dismiss
    @State private var isShowingMailComposer = false
    @State private var canSendMail = false

    var body: some View {
        Group {
            if canSendMail {
                MailComposeViewControllerWrapper(subject: subject,
                                                 body: body,
                                                 recipients: recipients,
                                                 attachmentURL: attachmentURL,
                                                 attachmentMimeType: attachmentMimeType,
                                                 attachmentFileName: attachmentFileName,
                                                 isPresented: $isShowingMailComposer,
                                                 dismissAction: dismiss)
                    .onAppear {
                        isShowingMailComposer = true
                    }
                    .sheet(isPresented: $isShowingMailComposer, onDismiss: {
                        dismiss()
                    }) {
                        MailComposeViewControllerWrapper(subject: subject,
                                                         body: body,
                                                         recipients: recipients,
                                                         attachmentURL: attachmentURL,
                                                         attachmentMimeType: attachmentMimeType,
                                                         attachmentFileName: attachmentFileName,
                                                         isPresented: $isShowingMailComposer,
                                                         dismissAction: dismiss)
                    }
            } else {
                MailUnavailableView(dismiss: dismiss)
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
    var body: String
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
        vc.setMessageBody(body, isHTML: false)
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

