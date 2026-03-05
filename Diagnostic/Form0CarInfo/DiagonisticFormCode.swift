import SwiftUI
import UIKit

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

struct DiagnosticPage<Next: View, Previous: View>: View {
    @EnvironmentObject var photoStore: PhotoStore
    @EnvironmentObject var printStore: PrintStore
    
    let category: DiagnosticCategory
    let sectionTitle: String
    let logKey: String
    let logLabel: String
    let photoKey: String?
    let photoButtonTitle: String?
    let next: Next
    let previous: Previous
    
    
    struct DiagnosticStatus: CustomStringConvertible {
        var red: Bool
        var yellow: Bool
        var green: Bool
        var description: String { "DiagnosticStatus(red: \(red), yellow: \(yellow), green: \(green))" }
    }
    
    @State private var showCamera = false
    @State private var notes: String = ""
    @State private var status: DiagnosticColor = .none
    
    var body: some View {
        NavigationStack {
            ZStack {
                LinearGradient(colors: [Color(.systemBackground), Color(.secondarySystemBackground)], startPoint: .top, endPoint: .bottom)
                    .ignoresSafeArea()
                // Header
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
                                        showCamera = true
                                    } label: {
                                        Label(photoButtonTitle, systemImage: "camera")
                                            .frame(maxWidth: .infinity)
                                    }
                                    .buttonStyle(.borderedProminent)
                                    .sheet(isPresented: $showCamera) {
                                        CameraPicker(images: .constant([]), onConfirm: { captured in
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
                                    print(message)
                                } label: {
                                    Label("Confirm", systemImage: "checkmark.circle.fill")
                                        .font(.title3.weight(.semibold))
                                        .frame(maxWidth: .infinity)
                                }
                                .buttonStyle(.borderedProminent)
                                // Page movement
                                HStack(spacing: 12) {
                                    NavigationLink {
                                        previous
                                    } label: {
                                        Label("Previous", systemImage: "chevron.left.2")
                                            .frame(maxWidth: .infinity)
                                    }
                                    .buttonStyle(.bordered)
                                    
                                    NavigationLink {
                                        next
                                    } label: {
                                        Label("Next", systemImage: "chevron.right.2")
                                            .frame(maxWidth: .infinity)
                                    }
                                    .buttonStyle(.bordered)
                                }
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

