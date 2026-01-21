//
//  DiagnosticApp.swift
//  Diagnostic
//
//  Created by Dylan J. Widmayer on 12/15/25.
//

import SwiftUI
import FirebaseFirestore
@main
struct DiagnosticApp: App {
    @StateObject var printStore = PrintStore()
       @StateObject var photoStore = PhotoStore()

       var body: some Scene {
           WindowGroup {
               NavigationStack {
                   diagnosticView1()
               }
               .environmentObject(printStore)
               .environmentObject(photoStore)
           }
       }
   }
