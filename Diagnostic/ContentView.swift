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
                    Text("Welcome To Diagnostic")
                        .font(.system(size: 48, weight: .heavy, design: .default))
                        .foregroundStyle(.white)
                        .shadow(color: .black.opacity(0.6), radius: 6, x: 0, y: 30)
                        .padding(.bottom, 40)
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
                   
                    NavigationLink {
                        PrintSummaryView()
                    } label: {
                        Text("See Past Reports")
                            .font(.largeTitle)
                            .fontWeight(.bold)
                            .frame(maxWidth: 650)
                            .frame(maxHeight: 100)
                            .padding(.vertical, 18)
                    }
                    .buttonStyle(.borderedProminent)
                    .padding(15)
                }
                
            }
        }
    }
}
#Preview {
    ContentView()
}

