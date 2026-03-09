//
//  ContentView.swift
//  Diagnostic
//
//  Created by Dylan J. Widmayer on 12/15/25.
//

import SwiftUI
import AVKit

struct ContentView: View {
    @State private var showTitle = false
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
                    ZStack(alignment: .center) {
                        VStack(spacing: 8) {
                            ZStack(alignment: .leading) {
                                Image("TireMarks")
                                    .resizable()
                                    .scaledToFit()
                                    .frame(height: 24)
                                    .opacity(0)
                                    .offset(x: -24)
                                    .rotationEffect(Angle(degrees: 38))

                                Text("Welcome To Diagnostic")
                                    .font(.system(size: 48, weight: .heavy, design: .default))
                                    .opacity(0)
                            }
                        }
                        VStack(spacing: 8) {
                            ZStack(alignment: .leading) {
                                if showTitle {
                                    Text("Welcome To Diagnostic")
                                        .font(.system(size: 48, weight: .heavy, design: .default))
                                        .foregroundStyle(.white)
                                        .shadow(color: .black.opacity(0.9), radius: 6.5, x: 0, y: -5)
                                        .transition(.move(edge: .leading))
                                }
                            }
                        }
                    }
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
            .onAppear {
                withAnimation(.easeOut(duration: 0.75)) {
                    showTitle = true
                }
            }
        }
    }
}
#Preview {
    ContentView()
}

