//
//  CameraProof.swift
//  Diagnostic
//
//  Created by Dylan J. Widmayer on 1/7/26.
//
import SwiftUI

struct CameraExampleView: View {
    @State var showCamera = false
    @State var image: UIImage?
    
    var body: some View {
        VStack {
            if let image = image {
                Image(uiImage: image)
                    .resizable()
                    .scaledToFit()
                    .frame(height: 350)
                    .padding()
            } else {
                Text("No Image Yet")
                    .foregroundColor(.gray)
            }
            
            Button("Take Picture") {
                showCamera = true
            }
            .padding()
            .font(.title2)
        }
        .sheet(isPresented: $showCamera) {
            CameraPicker(image: $image)
        }
    }
}

