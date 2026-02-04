//
//  CameraProof2.swift
//  Diagnostic
//
//  Created by Dylan J. Widmayer on 1/7/26.
//
import SwiftUI
import UIKit


struct CameraPicker: UIViewControllerRepresentable {
    @Binding var images: [UIImage]
    var onCapture: ((UIImage) -> Void)? = nil

    func makeUIViewController(context: Context) -> UIImagePickerController {
        let picker = UIImagePickerController()
        picker.sourceType = .camera
        picker.delegate = context.coordinator
        return picker
    }

    func updateUIViewController(_ uiViewController: UIImagePickerController, context: Context) {}

    func makeCoordinator() -> Coordinator {
        Coordinator(self)
    }

    class Coordinator: NSObject, UINavigationControllerDelegate, UIImagePickerControllerDelegate {
        let parent: CameraPicker

        init(_ parent: CameraPicker) {
            self.parent = parent
        }

        func imagePickerController(
            _ picker: UIImagePickerController,
            didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]
        ) {
            if let image = info[.originalImage] as? UIImage {
                parent.images.append(image)
                parent.onCapture?(image)
            }
            picker.dismiss(animated: true)
        }

        func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
            picker.dismiss(animated: true)
        }
    }
}
struct CameraExampleView: View {
    @State private var showCamera = false
    @State private var images: [UIImage] = []
    @State private var navigateToReview = false
    @State private var lastCapturedImage: UIImage?

    var body: some View {
        NavigationStack {
            VStack {
                if images.isEmpty {
                    Text("No Image Yet")
                        .foregroundColor(.gray)
                } else {
                    ScrollView(.horizontal) {
                        HStack(spacing: 12) {
                            ForEach(Array(images.enumerated()), id: \.offset) { _, img in
                                Image(uiImage: img)
                                    .resizable()
                                    .scaledToFit()
                                    .frame(width: 200, height: 200)
                                    .cornerRadius(8)
                            }
                        }
                        .padding(.horizontal)
                    }
                    .frame(height: 220)
                }

                Button("Take Picture") {
                    showCamera = true
                }
                .padding()
                .font(.title2)
            }
            .navigationDestination(isPresented: $navigateToReview) {
                ReviewPhotoView(image: lastCapturedImage)
            }
            .navigationTitle("Camera")
            .sheet(isPresented: $showCamera) {
                CameraPicker(images: $images) { captured in
                    lastCapturedImage = captured
                    navigateToReview = true
                }
            }
        }
    }
}

struct ReviewPhotoView: View {
    let image: UIImage?

    var body: some View {
        VStack {
            if let image {
                Image(uiImage: image)
                    .resizable()
                    .scaledToFit()
                    .padding()
            } else {
                Text("No image to review")
                    .foregroundColor(.secondary)
            }
        }
        .navigationTitle("Review")
    }
}

#Preview {
    CameraExampleView()
}

