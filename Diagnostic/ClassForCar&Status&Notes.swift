//
//  ClassForCar&Status&Notes.swift
//  Diagnostic
//

//
import SwiftUI
import Foundation
import Combine

struct carInfoClass: Identifiable {
    let id = UUID()
    var carVin: String
    var make: String
    var year: Int
    var carOwner: String
    var carGmail: String
    
    init(carVin: String, make: String, year: Int, carOwner: String, carGmail: String) {
        self.carVin = carVin
        self.make = make
        self.year = year
        self.carOwner = carOwner
        self.carGmail = carGmail
    }
}

struct status: Identifiable {
    let id = UUID()
    var red: Bool
    var yellow: Bool
    var green: Bool
    
    init(red: Bool, yellow: Bool, green: Bool) {
        self.red = red
        self.yellow = yellow
        self.green = green
    }
}

// A very simple note model (renamed to avoid conflicts)
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

//stores notes
final class SimpleStudentNotesAppStorage: ObservableObject {
    // We keep everything in one list and save it as JSON
    @AppStorage("student_notes_json") private var raw: String = ""
    
    @Published private(set) var notes: [SimpleStudentNote] = []
    
    init() {
        loadFromRaw()
    }
    
    // Add a new note
    func add(_ note: SimpleStudentNote) {
        notes.append(note)
        persist()
    }
    
    // Update an existing note by id
    func update(_ note: SimpleStudentNote) {
        if let idx = notes.firstIndex(where: { $0.id == note.id }) {
            notes[idx] = note
            persist()
        }
    }
    
    // Delete a note by id
    func delete(id: UUID) {
        notes.removeAll { $0.id == id }
        persist()
    }
    
    // Get notes for a specific car VIN, newest first
    func notes(forCarVin vin: String) -> [SimpleStudentNote] {
        notes
            .filter { $0.carVin == vin }
            .sorted { $0.timestamp > $1.timestamp }
    }
    
    // Persistence helpers
    private func loadFromRaw() {
        guard !raw.isEmpty, let data = raw.data(using: .utf8) else {
            notes = []
            return
        }
        do {
            notes = try JSONDecoder().decode([SimpleStudentNote].self, from: data)
        } catch {
            // If decoding fails, start fresh
            notes = []
        }
    }
    
    private func persist() {
        do {
            let data = try JSONEncoder().encode(notes)
            if let string = String(data: data, encoding: .utf8) {
                raw = string
            }
        } catch {
            // Ignore encoding errors i guess
        }
    }
}

struct ReportViewHelper {
    static func statusLines(from s: status) -> [String] {
        var items: [String] = []
        if s.red { items.append("Status: Red") }
        if s.yellow { items.append("Status: Yellow") }
        if s.green { items.append("Status: Green") }
        return items
    }
}
// Status history (simple, high-school level)

// One saved status snapshot for a car (who, when, and which light is on)
struct StatusEntry: Identifiable, Codable, Equatable {
    // We keep the VIN, time, and which light is true
    let id: UUID
    let timestamp: Date
    var carVin: String
    var red: Bool
    var yellow: Bool
    var green: Bool

    init(carVin: String, red: Bool, yellow: Bool, green: Bool) {
        self.id = UUID()
        self.timestamp = Date()
        self.carVin = carVin
        self.red = red
        self.yellow = yellow
        self.green = green
    }
}

// Keeps a list of status snapshots for each car and saves them as JSON
final class StatusHistoryStore: ObservableObject {
    @AppStorage("car_status_history_json") private var raw: String = ""
    @Published private(set) var entries: [StatusEntry] = []

    init() { load() }

    /// Record a new status for this car (red/yellow/green).
    // Easy way to record a status for a car VIN (adds a snapshot to history)
    func setStatus(for vin: String, red: Bool, yellow: Bool, green: Bool) {
        let entry = StatusEntry(carVin: vin, red: red, yellow: yellow, green: green)
        add(entry)
    }

    /// Add a status entry to the list and save.
    func add(_ entry: StatusEntry) {
        entries.append(entry)
        save()
    }

    /// Get the most recent status for this car.
    func latest(for vin: String) -> StatusEntry? {
        entries
            .filter { $0.carVin == vin }
            .sorted { $0.timestamp > $1.timestamp }
            .first
    }

    /// Get all saved statuses for this car (newest first).
    func history(for vin: String) -> [StatusEntry] {
        entries
            .filter { $0.carVin == vin }
            .sorted { $0.timestamp > $1.timestamp }
    }

    /// Delete one status entry by its id.
    func delete(id: UUID) {
        entries.removeAll { $0.id == id }
        save()
    }

    /// Delete all status entries for this car.
    func clearHistory(for vin: String) {
        entries.removeAll { $0.carVin == vin }
        save()
    }

    // Load from JSON string in AppStorage
    private func load() {
        guard !raw.isEmpty, let data = raw.data(using: .utf8) else {
            entries = []
            return
        }
        do {
            entries = try JSONDecoder().decode([StatusEntry].self, from: data)
        } catch {
            entries = []
        }
    }

   //******Enter the catch if theres an error***/do later
    // Save to JSON string in AppStorage
    private func save() {
        do {
            let data = try JSONEncoder().encode(entries)
            raw = String(data: data, encoding: .utf8) ?? ""
        } catch {
            
        }
    }
}

