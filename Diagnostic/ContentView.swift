//
//  ContentView.swift
//  Diagnostic
//
//  Created by Dylan J. Widmayer on 12/15/25.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        NavigationStack {
            ZStack {
                Image("BackGround")
                    .resizable()
                    .scaledToFill()
                    .imageScale(.large)
                    .foregroundStyle(.tint)
                
                VStack(spacing: 20) {
                    NavigationLink("Start Diagnostic Report"){
                        diagnosticView1()
                    }
                    .buttonStyle(.borderedProminent)
                }
                
            }
        }
    }
}
#Preview {
    ContentView()
}
