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
                    .ignoresSafeArea()
                    .imageScale(.large)
                    .foregroundStyle(.tint)
                
                VStack {
                    Text("Welcome To Diagnostic")
                        .transition(.move(edge: .top))
                        .font(.system(size: 48, weight: .heavy, design: .default))
                        .foregroundStyle(.white)
                        .shadow(color: .black.opacity(0.9), radius: 6.5, x: 0, y: -5)
                        .padding(.bottom, 30)
                    
                    NavigationLink {
                        DiagnosticView1()
                            .environmentObject(PhotoStore())
                            .environmentObject(PrintStore())
                            .environmentObject(ReportStore())
                    } label: {
                        Text("Start Diagnostic Report")
                            .font(.largeTitle)
                            .fontWeight(.bold)
                            .frame(maxWidth: 650)
                            .frame(maxHeight: 100)
                            .padding(.vertical, 18)
                    }
                    .buttonStyle(.borderedProminent)
                    .padding(15)
                   
                    NavigationLink {
                       PastReportsPage()
                            .environmentObject(PrintStore())
                            .environmentObject(ReportStore())
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
                    
                    NavigationLink {
                        CarMap()
                    } label: {
                        Text("See Car Map")
                            .font(.largeTitle)
                            .fontWeight(.bold)
                            .frame(maxWidth: 650)
                            .frame(maxHeight: 100)
                            .padding(.vertical, 18)
                    }
                    .buttonStyle(.borderedProminent)
                    .padding(15)
                }
                .padding(.top, 40)
                
            }
        }
    }
}
#Preview {
    ContentView()
}

