//
//  LogStore.swift
//  Diagnostic
//
//  Created by Nicholas C. Wiesneth on 1/21/26.
//
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

