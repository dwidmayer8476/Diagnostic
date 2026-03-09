//
//  Untitled.swift
//  Diagnostic
//
//  Created by Dylan J. Widmayer on 2/23/26.
//
import SwiftUI

struct PastReportsPage: View {
    
    @EnvironmentObject var reportStore: ReportStore
    @EnvironmentObject var notesStore: SimpleStudentNotesAppStorage
    
    @AppStorage("reportsGroupByMonth") private var groupByMonth: Bool = false

    //store by date part
    private var sortedReports: [CarReport] {
        reportStore.reports.sorted { $0.checkInDate > $1.checkInDate }
    }
    
    private func monthTitle(for date: Date) -> String {
        let df = DateFormatter()
        df.dateFormat = "LLLL yyyy" // e.g., March 2026
        return df.string(from: date)
    }
    
    private var sectionedReports: [(key: Date, reports: [CarReport])] {
        let calendar = Calendar.current
        let sortNewestFirst = true
        
        if groupByMonth {
            // Group by month (first day of the month)
            let grouped = Dictionary(grouping: reportStore.reports) { report -> Date in
                let components = calendar.dateComponents([.year, .month], from: report.checkInDate)
                return calendar.date(from: components)!
            }
            
            let sortedKeys = grouped.keys.sorted(by: { sortNewestFirst ? $0 > $1 : $0 < $1 })
            return sortedKeys.map { key in
                let sortedReports = grouped[key]!.sorted(by: { sortNewestFirst ? $0.checkInDate > $1.checkInDate : $0.checkInDate < $1.checkInDate })
                return (key: key, reports: sortedReports)
            }
        } else {
            // Group by day
            let grouped = Dictionary(grouping: reportStore.reports) { report in
                calendar.startOfDay(for: report.checkInDate)
            }
            
            let sortedKeys = grouped.keys.sorted(by: { sortNewestFirst ? $0 > $1 : $0 < $1 })
            return sortedKeys.map { key in
                let sortedReports = grouped[key]!.sorted(by: { sortNewestFirst ? $0.checkInDate > $1.checkInDate : $0.checkInDate < $1.checkInDate })
                return (key: key, reports: sortedReports)
            }
        }
    }
    
    var body: some View {
        VStack(alignment: .leading) {
            Text("Past Reports")
                .font(.largeTitle)
                .frame(maxWidth: .infinity, alignment: .center)
                .padding(.vertical, 16)
            
            // Past Reports
            if !reportStore.reports.isEmpty {
                Text("Past Reports")
                    .font(.title2)
                    .padding(.bottom, 5)
                    .frame(maxWidth: .infinity, alignment: .center)
                List {
                    ForEach(sectionedReports, id: \.key) { section in
                        Section(header: Text(groupByMonth ? monthTitle(for: section.key) : DateFormatter.localizedString(from: section.key, dateStyle: .medium, timeStyle: .none))) {
                            ForEach(section.reports, id: \.carVin) { report in
                                VStack(alignment: .leading) {
                                    Text("\(report.year) \(report.make) (VIN \(report.carVin))")
                                        .font(.headline)
                                    Text("\(report.carOwner) • \(report.checkInDate, style: .date) \(report.checkInDate, style: .time)")
                                        .font(.subheadline)
                                        .foregroundColor(.secondary)
                                    Text("Notes unavailable for this report")
                                        .font(.body)
                                        .foregroundColor(.secondary)
                                }
                                .padding(.vertical, 4)
                            }
                        }
                    }
                }
                .listStyle(.plain)
                .padding(.bottom, 30)
            }
        }
        .toolbar {
            ToolbarItem(placement: .topBarTrailing) {
                Picker("Group", selection: $groupByMonth) {
                    Text("Day").tag(false)
                    Text("Month").tag(true)
                }
                .pickerStyle(.segmented)
                .frame(width: 160)
            }
        }
    }
}

