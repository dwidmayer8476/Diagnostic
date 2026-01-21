import SwiftUI
import UIKit
import Combine

@MainActor
    final class PhotoStore: ObservableObject {
    @Published var imagesByKey: [String: UIImage] = [:]
}
