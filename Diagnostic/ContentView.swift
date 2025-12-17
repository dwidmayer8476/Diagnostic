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
            Text("test")
        }
    }
}

#Preview {
    ContentView()
}
