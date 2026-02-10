//
//  ImagePicker.swift
//  Diagnostic
//
//  Created by Dylan J. Widmayer on 2/2/26.
//
import UIKit

extension UIApplication {
    func topMostController() -> UIViewController? {
        guard var top = connectedScenes
            .compactMap({ ($0 as? UIWindowScene)?.keyWindow })
            .first?.rootViewController else { return nil }

        while let presented = top.presentedViewController {
            top = presented
        }
        return top
    }
}

