//
//  Untitled.swift
//  Diagnostic
//
//  Created by Dylan J. Widmayer on 2/23/26.
//
import SwiftUI

struct PastReportsPage: View {
    
    @EnvironmentObject var reportStore: ReportStore
    
    var body: some View {
        VStack(alignment: .leading) {
            Text("Past Reports")
                .font(.largeTitle)
                .frame(maxWidth: .infinity, alignment: .center)
                .padding(.vertical, 16)

            if reportStore.reports.isEmpty {
                ContentUnavailableView("No Reports Yet", systemImage: "tray", description: Text("Reports you confirm will appear here."))
                .frame(maxWidth: .infinity, maxHeight: .infinity)
            } else {
                List(sortedReports) { report in
                    VStack(alignment: .leading, spacing: 6) {
                        HStack {
                            Text("VIN:").bold()
                            Text(report.carVin)
                        }
                        HStack {
                            Text("Make:").bold()
                            Text(report.make)
                        }
                        HStack {
                            Text("Year:").bold()
                            Text(String(report.year))
                        }
                        HStack {
                            Text("Owner:").bold()
                            Text(report.carOwner)
                        }
                        HStack {
                            Text("Check-in:").bold()
                            Text(report.checkInDate, style: .date)
                            Text(report.checkInDate, style: .time)
                        }
                    }
                    .padding(.vertical, 4)
                }
                .listStyle(.plain)
            }
        }
        .padding()
    }
    
    private var sortedReports: [CarReport] {
        reportStore.reports.sorted { $0.checkInDate > $1.checkInDate }
    }
}

#Preview {
    PastReportsPage()
        .environmentObject(ReportStore())
}

