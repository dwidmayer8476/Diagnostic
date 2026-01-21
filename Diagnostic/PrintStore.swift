//
//  LogStore.swift
//  Diagnostic
//
//  Created by Nicholas C. Wiesneth on 1/21/26.
//
import SwiftUI
import Combine

class PrintStore: ObservableObject {
    @Published var messages: [String] = []

    func log(_ message: String) {
        messages.append(message)
    }
}

