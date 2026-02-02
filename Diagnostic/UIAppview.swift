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
