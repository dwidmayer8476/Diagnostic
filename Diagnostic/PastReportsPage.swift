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
    //store by date part
    private var sortedReports: [CarReport] {
        reportStore.reports.sorted { $0.checkInDate > $1.checkInDate }
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
                    ForEach(sortedReports, id: \.carVin) { report in
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
                .listStyle(.plain)
                .padding(.bottom, 30)
            }
        }
    }
}

