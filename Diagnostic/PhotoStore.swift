import SwiftUI
import UIKit
import Combine

@MainActor
final class PhotoStore: ObservableObject {
    // Store images by a string key (e.g., "page1", "page2")
    @Published var imagesByKey: [String: UIImage] = [:]
}
