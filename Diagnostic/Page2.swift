//
//  PageTwi.swift
//  Diagnostic
//
//  Created by Nicholas C. Wiesneth on 12/17/25.
//
import SwiftUI

struct Status {
    var red: Bool
    var yellow: Bool
    var green: Bool
}

struct diagnosticView2: View {
    
    @State private var status = Status(red: false, yellow: false, green: false)
    
    var body: some View {
        VStack(spacing: 20) {
            Text("Under Hood / Maintence Service")
                .font(.largeTitle)
                .foregroundStyle(.red)
                .padding(10)
            Text("Wiper Blades")
                .font(.largeTitle)
                .foregroundStyle(.black)
            
            Image("Rules")
            
            Button("Red") {
                status.red = true
                status.yellow = false
                status.green = false
            }
            
            Button("Yellow") {
                status.red = false
                status.yellow = true
                status.green = false
            }
            
            Button("Green") {
                status.red = false
                status.yellow = false
                status.green = true
            }
            
            Button("Confirm?") {
                print(status)
            }
            .font(.largeTitle)
            .foregroundStyle(.red)
            .padding(5)
            NavigationLink("Next Page") {
                diagnosticView3()
            }
        }
    }
}
