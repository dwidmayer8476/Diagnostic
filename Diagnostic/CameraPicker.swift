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
    var onConfirm: ((UIImage) -> Void)? = nil

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
    @State private var isShowingReview = false
    @State private var pendingImage: UIImage?

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
            .navigationTitle("Camera")
            .sheet(isPresented: $showCamera) {
                CameraPicker(images: $images, onCapture: { captured in
                    pendingImage = captured
                    isShowingReview = true
                })
            }
            .sheet(isPresented: $isShowingReview) {
                ReviewPhotoActionSheet(
                    image: pendingImage,
                    onUse: {
                        if let img = pendingImage {
                            // If needed, append to images or forward to a store
                            images.append(img)
                        }
                        pendingImage = nil
                        isShowingReview = false
                    },
                    onRetake: {
                        pendingImage = nil
                        isShowingReview = false
                        showCamera = true
                    }
                )
            }
        }
    }
}

struct ReviewPhotoActionSheet: View {
    let image: UIImage?
    let onUse: () -> Void
    let onRetake: () -> Void

    var body: some View {
        NavigationStack {
            VStack(spacing: 16) {
                if let image {
                    Image(uiImage: image)
                        .resizable()
                        .scaledToFit()
                        .clipShape(RoundedRectangle(cornerRadius: 12))
                        .padding()
                } else {
                    Text("No image to review")
                        .foregroundColor(.secondary)
                }

                HStack {
                    Button("Retake", role: .destructive, action: onRetake)
                    Spacer()
                    Button("Use Photo", action: onUse)
                        .buttonStyle(.borderedProminent)
                }
                .padding(.horizontal)
            }
            .navigationTitle("Review Photo")
            .navigationBarTitleDisplayMode(.inline)
        }
    }
}

#Preview {
    CameraExampleView()
}

