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
                
                VStack {
                    
                    NavigationLink {
                        diagnosticView1()
                    } label: {
                        Text("Start Diagnostic Report")
                            .font(.largeTitle)
                            .fontWeight(.bold)
                            .frame(maxWidth: 650)
                            .frame(maxHeight: 100)
                            .padding(.vertical, 18)
                    }
                    .buttonStyle(.borderedProminent)
                    .padding(.horizontal, 30)
                }
                
            }
        }
    }
}
#Preview {
    ContentView()
}
