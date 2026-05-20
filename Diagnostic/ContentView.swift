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
    @State private var revealProgress: CGFloat = 0
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
                        ZStack(alignment: .leading) {
                            let titleView = Text("Welcome To Diagnostic")
                                .font(.system(size: 48, weight: .heavy, design: .default))
                                .foregroundStyle(.white)
                                .shadow(color: .black.opacity(0.9), radius: 6.5, x: 0, y: -5)

                            titleView
                                .mask(
                                    GeometryReader { geo in
                                        Rectangle()
                                            .frame(width: geo.size.width * max(0, min(1, revealProgress)))
                                    }
                                )
                                .animation(.easeOut(duration: 1.0), value: revealProgress)

                            Image("tire")
                                .resizable()
                                .scaledToFit()
                                .frame(width: 56, height: 56)
                                .shadow(color: .black.opacity(0.6), radius: 4, x: 0, y: 1)
                                .offset(x: -80 + 540 * revealProgress, y: 0)
                                .rotationEffect(.degrees(Double(360 * revealProgress)))
                                .animation(.easeOut(duration: 1.0), value: revealProgress)
                        }
                    }
                    .padding(.bottom, 30)
                    
                    NavigationLink {
                        GiantDiagnosticList()
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
                revealProgress = 0
                showTitle = false
                withAnimation(.easeOut(duration: 1.0)) {
                    revealProgress = 1
                    showTitle = true
                }
            }
        }
    }
}
#Preview {
    ContentView()
}

