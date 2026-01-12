//
//  PageTwi.swift
//  Diagnostic
//
//  Created by Nicholas C. Wiesneth on 12/17/25.
//
import SwiftUI

struct diagnosticView2: View {

    @State private var status = Status(red: false, yellow: false, green: false)

    var body: some View {
        VStack(spacing: 20) {

            Text("Under Hood / Maintenance Service")
                .font(.largeTitle)
                .foregroundStyle(.red)
                .padding(10)

            Text("Wiper Blades")
                .font(.largeTitle)

            Image("Rules")

            Button("Red") {
                status = Status(red: true, yellow: false, green: false)
            }

            Button("Yellow") {
                status = Status(red: false, yellow: true, green: false)
            }

            Button("Green") {
                status = Status(red: false, yellow: false, green: true)
            }

            Button("Confirm?") {
                print(status)
            }
            .font(.largeTitle)
            .foregroundStyle(.red)

            NavigationLink("Next Page") {
                diagnosticView3()
            }

            NavigationLink("Previous Page") {
                diagnosticView1()
            }
        }
    }
}

