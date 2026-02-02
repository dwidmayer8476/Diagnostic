//
//  DiagnosticApp.swift
//  Diagnostic
//
//  Created by Dylan J. Widmayer on 12/15/25.
//

import SwiftUI
@main
struct DiagnosticApp: App {
    @StateObject var printStore = PrintStore()
       @StateObject var photoStore = PhotoStore()

       var body: some Scene {
           WindowGroup {
            
                   ContentView()
               
               .environmentObject(printStore)
               .environmentObject(photoStore)
           }
       }
   }
