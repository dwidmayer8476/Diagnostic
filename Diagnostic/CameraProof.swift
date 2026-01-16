////
////  CameraProof.swift
////  Diagnostic
////
////  Created by Dylan J. Widmayer on 1/7/26.
////
//import SwiftUI
//
//struct LeraExampleView: View {
//    @State var showCamera = false
//    @State var images: [UIImage] = []
//    
//    var body: some View {
//        VStack {
//            if images.isEmpty {
//                Text("No Image Yet")
//                    .foregroundColor(.gray)
//            } else {
//                ScrollView(.horizontal) {
//                    HStack(spacing: 12) {
//                        ForEach(Array(images.enumerated()), id: \.offset) { _, img in
//                            Image(uiImage: img)
//                                .resizable()
//                                .scaledToFit()
//                                .frame(width: 200, height: 200)
//                                .cornerRadius(8)
//                        }
//                    }
//                    .padding(.horizontal)
//                }
//                .frame(height: 220)
//            }
//            
//            Button("Take Picture") {
//                showCamera = true
//            }
//            .padding()
//            .font(.title2)
//        }
//        .sheet(isPresented: $showCamera) {
//            CameraPicker(images: $images)
//        }
//    }
//}
//
