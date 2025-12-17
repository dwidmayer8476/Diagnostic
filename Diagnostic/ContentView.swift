//
//  ContentView.swift
//  Diagnostic
//
//  Created by Dylan J. Widmayer on 12/15/25.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        ZStack {
            Image("BackGround")
                .imageScale(.large)
                .foregroundStyle(.tint)
            Text("Hello, world!")
                .foregroundStyle(.white)
                .padding()
                .background(Color.blue)
                .cornerRadius(10)
            
        }
    }
}

#Preview {
    ContentView()
}
