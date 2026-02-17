//import Foundation
//import UIKit
//import SwiftUI
//import Combine
//
//@MainActor
//struct PhotoUtilities {
//    static func downsample(image: UIImage, to maxDimension: CGFloat) -> UIImage {
//        let size = image.size
//        let scale = min(maxDimension / max(size.width, size.height), 1)
//        if scale >= 1 { return image }
//        let newSize = CGSize(width: size.width * scale, height: size.height * scale)
//        let renderer = UIGraphicsImageRenderer(size: newSize)
//        return renderer.image { _ in
//            image.draw(in: CGRect(origin: .zero, size: newSize))
//        }
//    }
//}

