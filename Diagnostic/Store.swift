import SwiftUI
import UIKit
import Combine
import UniformTypeIdentifiers

@MainActor
final class PhotoStore: ObservableObject {
    @Published var imagesByKey: [String: UIImage] = [:]

    @AppStorage("photoBlobs") private var photoBlobsData: Data = Data()

    private var photoBlobs: [String: Data] {
        get {
            guard !photoBlobsData.isEmpty else { return [:] }
            return (try? JSONDecoder().decode([String: Data].self, from: photoBlobsData)) ?? [:]
        }
        set {
            photoBlobsData = (try? JSONEncoder().encode(newValue)) ?? Data()
        }
    }

    @discardableResult
    func save(image: UIImage) throws -> String {
        guard let data = image.jpegData(compressionQuality: 0.9) else {
            throw NSError(domain: "PhotoStore", code: -1, userInfo: [NSLocalizedDescriptionKey: "Failed to encode image as JPEG"])
        }
        let fileName = UUID().uuidString + ".jpg"
        var blobs = photoBlobs
        blobs[fileName] = data
        photoBlobs = blobs
        imagesByKey[fileName] = image
        return fileName
    }

    func loadImage(named fileName: String) -> UIImage? {
        if let cached = imagesByKey[fileName] { return cached }
        guard let data = photoBlobs[fileName], let img = UIImage(data: data) else { return nil }
        imagesByKey[fileName] = img
        return img
    }

    func deleteImage(named fileName: String) {
        imagesByKey.removeValue(forKey: fileName)
        var blobs = photoBlobs
        if blobs.removeValue(forKey: fileName) != nil {
            photoBlobs = blobs
        }
    }

    func allSavedFileNames() -> [String] {
        return photoBlobs.keys.sorted()
    }
}

// PrintStore
import SwiftUI
import Combine

class PrintStore: ObservableObject {
    @Published var messagesByKey: [String: String] = [:]

    var messages: [String] {
        messagesByKey.keys.sorted().compactMap { messagesByKey[$0] }
    }

    func log(_ message: String, for key: String) {
        messagesByKey[key] = message
    }
    func append(_ message: String) {
        let newKey = "legacy_\(UUID().uuidString)"
        messagesByKey[newKey] = message
    }
}

