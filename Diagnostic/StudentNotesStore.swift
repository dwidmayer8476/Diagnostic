import SwiftUI
import Foundation
import Combine

// note model
struct SimpleStudentNote: Identifiable, Codable, Equatable {
    let id: UUID
    let timestamp: Date
    var notes: String
    var carVin: String

    init(notes: String, carVin: String) {
        self.id = UUID()
        self.timestamp = Date()
        self.notes = notes
        self.carVin = carVin
    }
}

// stores notes
final class SimpleStudentNotesAppStorage: ObservableObject {
    
    @AppStorage("student_notes_json") private var raw: String = ""
    @Published private(set) var notes: [SimpleStudentNote] = []

    init() {
        if !raw.isEmpty, let data = raw.data(using: .utf8),
           let decoded = try? JSONDecoder().decode([SimpleStudentNote].self, from: data) {
            self.notes = decoded
        } else {
            self.notes = []
        }
    }

    func add(_ note: SimpleStudentNote) {
        notes.append(note)
        persist()
    }

    func update(_ note: SimpleStudentNote) {
        if let idx = notes.firstIndex(where: { $0.id == note.id }) {
            notes[idx] = note
            persist()
        }
    }

    func delete(id: UUID) {
        notes.removeAll { $0.id == id }
        persist()
    }

    func notes(forCarVin vin: String) -> [SimpleStudentNote] {
        notes.filter { $0.carVin == vin }.sorted { $0.timestamp > $1.timestamp }
    }

    private func loadFromRaw() {
        guard !raw.isEmpty, let data = raw.data(using: .utf8) else { notes = []; return }
        do {
            notes = try JSONDecoder().decode([SimpleStudentNote].self, from: data)
        } catch { notes = [] }
    }

    private func persist() {
        do {
            let data = try JSONEncoder().encode(notes)
            raw = String(data: data, encoding: .utf8) ?? ""
        } catch { }
    }
}
