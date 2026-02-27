//
//  classForVin.swift
//  Diagnostic
//
//  Created by Dylan J. Widmayer on 12/17/25.
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

// A report for a specific car (e.g., "Report 1", "Report 2")
struct StudentCarReport: Identifiable, Codable, Equatable {
    let id: UUID
    let createdAt: Date
    var carVin: String
    var title: String

    init(carVin: String, title: String) {
        self.id = UUID()
        self.createdAt = Date()
        self.carVin = carVin
        self.title = title
    }
}

//student noteholder
struct StudentNote: Identifiable, Codable, Equatable {
    let id: UUID
    let timestamp: Date
    var notes: String
    var carVin: String
    var reportID: UUID // ties this note to a specific report for the car

    init(notes: String, carVin: String, reportID: UUID) {
        self.id = UUID()
        self.timestamp = Date()
        self.notes = notes
        self.carVin = carVin
        self.reportID = reportID
    }
}

//jsondata app storage
final class StudentNotesAppStorage: ObservableObject {
    // JSON blob of all notes
    @AppStorage("student_notes_json") private var raw: String = ""
    @AppStorage("car_reports_json") private var rawReports: String = ""
    @AppStorage("legacy_report_map_json") private var rawLegacyReportMap: String = ""

    @Published private(set) var notes: [StudentNote] = []
    @Published private(set) var reports: [StudentCarReport] = []
    // creates an id to match with our past Reports
    private var legacyReportIDForCar: [String: UUID] = [:]
//loads our persited dta here
    init() {
        loadFromRaw()
        loadReportsFromRaw()
        loadLegacyMapFromRaw()
        migrateNotesIfNeeded()
    }

    func add(_ note: StudentNote) {
        notes.append(note)
        persist()
    }
//finds note id & replaces
    func update(_ note: StudentNote) {
        if let idx = notes.firstIndex(where: { $0.id == note.id }) {
            notes[idx] = note
            persist()
        }
    }
//deletes matches
    func delete(id: UUID) {
        notes.removeAll { $0.id == id }
        persist()
    }
//sorts by most recent to first
    func notes(forCarVin vin: String) -> [StudentNote] {
        notes
            .filter { $0.carVin == vin }
            .sorted { $0.timestamp > $1.timestamp }
    }
//decodes reports and makes empty array on failiure
    private func loadFromRaw() {
        guard !raw.isEmpty, let data = raw.data(using: .utf8) else {
            notes = []
            return
        }
        do {
            let decoded = try JSONDecoder().decode([StudentNote].self, from: data)
            notes = decoded
        } catch {
            // If decoding fails, reset to empty to avoid crashes
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
            // Handle encoding errors if necessary
        }
    }

    //reports for the memory
    private func loadReportsFromRaw() {
        guard !rawReports.isEmpty, let data = rawReports.data(using: .utf8) else {
            reports = []
            return
        }
        do {
            reports = try JSONDecoder().decode([StudentCarReport].self, from: data)
        } catch {
            reports = []
        }
    }
    private func persistReports() {
        do {
            let data = try JSONEncoder().encode(reports)
            if let string = String(data: data, encoding: .utf8) {
                rawReports = string
            }
        } catch {
            // Handle encoding errors if necessary
        }
    }

    // MARK: - Legacy map persistence
    private func loadLegacyMapFromRaw() {
        guard !rawLegacyReportMap.isEmpty, let data = rawLegacyReportMap.data(using: .utf8) else {
            legacyReportIDForCar = [:]
            return
        }
        do {
            legacyReportIDForCar = try JSONDecoder().decode([String: UUID].self, from: data)
        } catch {
            legacyReportIDForCar = [:]
        }
    }

    private func persistLegacyMap() {
        do {
            let data = try JSONEncoder().encode(legacyReportIDForCar)
            if let string = String(data: data, encoding: .utf8) {
                rawLegacyReportMap = string
            }
        } catch {
            // Handle encoding errors if necessary
        }
    }

   //Migration for pre-existing notes
    private func migrateNotesIfNeeded() {
        // If any legacy notes are missing a reportID, assign them to a per-car legacy report
        var changed = false

        // Build a map of the most recent report per car for convenience
        var mostRecentReportForCar: [String: StudentCarReport] = [:]
        for report in reports {
            let current = mostRecentReportForCar[report.carVin]
            if let current, current.createdAt >= report.createdAt {
                continue
            }
            mostRecentReportForCar[report.carVin] = report
        }

        // Ensure a legacy report ID exists per car to attach migrated notes to
        func legacyReportID(for vin: String) -> UUID {
            if let existing = legacyReportIDForCar[vin] {
                return existing
            }
            // Prefer the most recent existing report for this car; otherwise create one
            if let existingReport = mostRecentReportForCar[vin] {
                legacyReportIDForCar[vin] = existingReport.id
                return existingReport.id
            } else {
                let newReport = StudentCarReport(carVin: vin, title: "Report 1")
                reports.append(newReport)
                mostRecentReportForCar[vin] = newReport
                legacyReportIDForCar[vin] = newReport.id
                persistReports()
                return newReport.id
            }
        }

        // Migrate notes that may be missing a reportID from older persisted data
        // (If all notes already have reportIDs, this loop simply does nothing.)
        for index in notes.indices {
            // In current model, StudentNote always has reportID. This section handles older data where reportID may have been absent in storage.
            // Detect a placeholder/mismatched report by checking if the reportID doesn't belong to any report for the same car VIN.
            let vin = notes[index].carVin
            let noteReportID = notes[index].reportID
            let reportMatchesCar = reports.contains { $0.id == noteReportID && $0.carVin == vin }
            if !reportMatchesCar {
                let targetReportID = legacyReportID(for: vin)
                if notes[index].reportID != targetReportID {
                    notes[index].reportID = targetReportID
                    changed = true
                }
            }
        }

        if changed {
            persist()
            persistLegacyMap()
        }

        // Ensure there is at least one report per car if there are notes but no reports
        let carsWithNotes = Set(notes.map { $0.carVin })
        for vin in carsWithNotes {
            if !reports.contains(where: { $0.carVin == vin }) {
                let report = StudentCarReport(carVin: vin, title: "Report 1")
                reports.append(report)
                legacyReportIDForCar[vin] = report.id
                persistReports()
                persistLegacyMap()
            }
        }
    }

 //create the report
    func createNewReport(forCarVin vin: String, title: String? = nil, seedFromMostRecent: Bool = true) -> StudentCarReport {
        let countForCar = reports.filter { $0.carVin == vin }.count
        let newTitle = title ?? "Report \(countForCar + 1)"
        let newReport = StudentCarReport(carVin: vin, title: newTitle)
        reports.append(newReport)
        persistReports()

        if seedFromMostRecent {
            // Find most recent existing report for this car (excluding the new one)
            let existing = reports.filter { $0.carVin == vin && $0.id != newReport.id }
                .sorted { $0.createdAt > $1.createdAt }
                .first
            if let sourceReport = existing {
                // Copy notes from sourceReport into the new report
                let sourceNotes = notes.filter { $0.carVin == vin && $0.reportID == sourceReport.id }
                if !sourceNotes.isEmpty {
                    let cloned = sourceNotes.map { old in
                        StudentNote(notes: old.notes, carVin: vin, reportID: newReport.id)
                    }
                    notes.append(contentsOf: cloned)
                    persist()
                }
            }
        }
        return newReport
    }

    func notes(forReportID reportID: UUID) -> [StudentNote] {
        notes
            .filter { $0.reportID == reportID }
            .sorted { $0.timestamp > $1.timestamp }
    }

    func notesForMostRecentReport(forCarVin vin: String) -> [StudentNote] {
        guard let report = reports.filter({ $0.carVin == vin }).sorted(by: { $0.createdAt > $1.createdAt }).first else {
            return []
        }
        return notes(forReportID: report.id)
    }

    func mostRecentReport(forCarVin vin: String) -> StudentCarReport? {
        reports.filter { $0.carVin == vin }.sorted { $0.createdAt > $1.createdAt }.first
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
