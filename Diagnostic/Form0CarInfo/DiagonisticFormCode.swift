import SwiftUI
import UIKit
import AVFoundation
//add car parts circled
//vin take photo
//
enum DiagnosticCategory {
    case underHood
    case exhaust
    case steeringSuspension
    
    var headerTitle: String {
        switch self {
        case .underHood: return "Under Hood / Maintenance Service"
        case .exhaust: return "Exhaust System"
        case .steeringSuspension: return "Steering & Suspension"
        }
    }
}

struct DiagnosticPage: View {
    @EnvironmentObject var photoStore: PhotoStore
    @EnvironmentObject var printStore: PrintStore
    
    let category: DiagnosticCategory
    let sectionTitle: String
    let logKey: String
    let logLabel: String
    let photoKey: String?
    let photoButtonTitle: String?
    
    
    struct DiagnosticStatus: CustomStringConvertible {
        var red: Bool
        var yellow: Bool
        var green: Bool
        var description: String { "DiagnosticStatus(red: \(red), yellow: \(yellow), green: \(green))" }
    }
    
    @State private var showCamera = false
    @State private var notes: String = ""
    @State private var status: DiagnosticColor = .none
    @State private var capturedImages: [UIImage] = []
    
    private func presentCameraIfAuthorized() {
        switch AVCaptureDevice.authorizationStatus(for: .video) {
        case .authorized:
            showCamera = true
        case .notDetermined:
            AVCaptureDevice.requestAccess(for: .video) { granted in
                DispatchQueue.main.async {
                    if granted { showCamera = true }
                }
            }
        case .denied, .restricted:
            // Optionally present an alert guiding the user to Settings
            break
        @unknown default:
            break
        }
    }
    
    var body: some View {
        NavigationStack {
            ZStack {
                LinearGradient(colors: [Color(.systemBackground), Color(.secondarySystemBackground)], startPoint: .top, endPoint: .bottom)
                    .ignoresSafeArea()
                ScrollView {
                    VStack(spacing: 16) {
                        VStack(spacing: 8) {
                            HStack(spacing: 12) {
                                Image(systemName: "wrench.and.screwdriver")
                                    .symbolRenderingMode(.hierarchical)
                                    .font(.system(size: 36, weight: .semibold))
                                    .foregroundStyle(.tint)
                                VStack(alignment: .leading, spacing: 2) {
                                    Text(category.headerTitle)
                                        .font(.largeTitle).bold()
                                        .foregroundStyle(.primary)
                                    Text(sectionTitle)
                                        .font(.title3)
                                        .foregroundStyle(.secondary)
                                }
                                Spacer()
                            }
                            .padding(.horizontal)
                        }
                        .padding(.vertical, 8)
                        
                        HStack(alignment: .center) {
                            NavigationLink {
                                CarMap()
                            } label: {
                                Label("Open Car Map", systemImage: "map")
                                    .font(.title3)
                                    .padding(.horizontal, 8)
                                    .padding(.vertical, 6)
                            }
                            .buttonStyle(.borderedProminent)
                        }
                        .padding(.horizontal)
                        VStack(spacing: 20) {
                            // Rules
                            RoundedRectangle(cornerRadius: 16, style: .continuous)
                                .fill(.thinMaterial)
                                .overlay(
                                    Image("Rules")
                                        .resizable()
                                        .scaledToFit()
                                        .padding()
                                )
                                .frame(maxWidth: .infinity)
                                .frame(height: 140)
                            
                            // Status picker
                            VStack(alignment: .leading, spacing: 12) {
                                Text("Status")
                                    .font(.headline)
                                StatusPicker(selection: $status)
                                HStack {
                                    Image(systemName: "circle.fill")
                                        .foregroundStyle(status == .red ? .red : (status == .yellow ? .yellow : (status == .green ? .green : Color(.tertiaryLabel))))
                                    Text(status == .none ? "No status selected" : status.rawValue)
                                        .foregroundStyle(.secondary)
                                }
                                .font(.subheadline)
                            }
                            .padding()
                            .background(.thinMaterial, in: RoundedRectangle(cornerRadius: 16, style: .continuous))
                            
                            // Notes
                            VStack(alignment: .leading, spacing: 8) {
                                Text("Notes")
                                    .font(.headline)
                                TextEditor(text: $notes)
                                    .frame(minHeight: 120)
                                    .padding(10)
                                    .background(
                                        RoundedRectangle(cornerRadius: 12, style: .continuous)
                                            .fill(Color(.secondarySystemBackground))
                                    )
                                    .overlay(
                                        RoundedRectangle(cornerRadius: 12, style: .continuous)
                                            .strokeBorder(Color(.separator).opacity(0.2))
                                    )
                            }
                            .padding()
                            .background(.thinMaterial, in: RoundedRectangle(cornerRadius: 16, style: .continuous))
                            
                            // Photo
                            if let photoKey, let photoButtonTitle {
                                VStack(alignment: .leading, spacing: 12) {
                                    Text("Photos")
                                        .font(.headline)
                                    Button {
                                        presentCameraIfAuthorized()
                                    } label: {
                                        Label(photoButtonTitle, systemImage: "camera")
                                            .frame(maxWidth: .infinity)
                                    }
                                    .buttonStyle(.borderedProminent)
                                    .sheet(isPresented: $showCamera) {
                                        CameraPicker(images: $capturedImages, onCapture: { captured in
                                            photoStore.imagesByKey[photoKey] = captured
                                        })
                                    }
                                }
                                .padding()
                                .background(.thinMaterial, in: RoundedRectangle(cornerRadius: 16, style: .continuous))
                            }
                            
                            // Message
                            VStack(spacing: 12) {
                                Button {
                                    let message = """
                                    \(logLabel): Status: \(status.rawValue)
                                    Notes: \(notes)
                                    """
                                    printStore.log(message, for: logKey)
                                } label: {
                                    Label("Confirm", systemImage: "checkmark.circle.fill")
                                        .font(.title3.weight(.semibold))
                                        .frame(maxWidth: .infinity)
                                }
                                .buttonStyle(.borderedProminent)
                            }
                        }
                        .padding()
                    }
                    .padding(.vertical)
                    .navigationTitle("Diagnostic")
                    .navigationBarTitleDisplayMode(.inline)
                }
            }
        }
    }
}

