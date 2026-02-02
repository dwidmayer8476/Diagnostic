import UIKit
import SwiftUI
import MessageUI

final class AppMailComposerDelegate: NSObject, MFMailComposeViewControllerDelegate {
    static let shared = AppMailComposerDelegate()

    func mailComposeController(_ controller: MFMailComposeViewController,
                               didFinishWith result: MFMailComposeResult,
                               error: Error?) {
        controller.dismiss(animated: true)
    }
}
