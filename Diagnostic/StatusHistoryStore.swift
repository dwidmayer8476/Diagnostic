
import SwiftUI
import Foundation
import Combine

struct StatusEntry: Identifiable, Codable, Equatable {
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

// keeps a list of status for each car and saves them
final class StatusHistoryStore: ObservableObject {
    @AppStorage("car_status_history_json") private var raw: String = ""
    @Published private(set) var entries: [StatusEntry] = []

    init() { load() }

    func setStatus(for vin: String, red: Bool, yellow: Bool, green: Bool) {
        let entry = StatusEntry(carVin: vin, red: red, yellow: yellow, green: green)
        add(entry)
    }

    func add(_ entry: StatusEntry) {
        entries.append(entry)
        save()
    }

    func latest(for vin: String) -> StatusEntry? {
        entries.filter { $0.carVin == vin }.sorted { $0.timestamp > $1.timestamp }.first
    }

    func history(for vin: String) -> [StatusEntry] {
        entries.filter { $0.carVin == vin }.sorted { $0.timestamp > $1.timestamp }
    }

    func delete(id: UUID) {
        entries.removeAll { $0.id == id }
        save()
    }

    func clearHistory(for vin: String) {
        entries.removeAll { $0.carVin == vin }
        save()
    }

    private func load() {
        guard !raw.isEmpty, let data = raw.data(using: .utf8) else { entries = []; return }
        do { entries = try JSONDecoder().decode([StatusEntry].self, from: data) } catch { entries = [] }
    }

    private func save() {
        do {
            let data = try JSONEncoder().encode(entries)
            raw = String(data: data, encoding: .utf8) ?? ""
        } catch { }
    }
}
