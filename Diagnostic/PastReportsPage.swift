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
            
            // Past Reports
            if !reportStore.reports.isEmpty {
                Text("Past Reports")
                    .font(.title2)
                    .padding(.bottom, 5)
                    .frame(maxWidth: .infinity, alignment: .center)
                List(reportStore.reports) { report in
                    VStack(alignment: .leading) {
                        HStack {
                            Text("VIN:")
                                .bold()
                            Text(report.carVin)
                        }
                        HStack {
                            Text("Make:")
                                .bold()
                            Text(report.make)
                        }
                        HStack {
                            Text("Year:")
                                .bold()
                            Text(String(report.year))
                        }
                        HStack {
                            Text("Owner:")
                                .bold()
                            Text(report.carOwner)
                        }
                        HStack {
                            Text("Check-in:")
                                .bold()
                            Text(report.checkInDate, style: .date)
                        }
                    }
                    .padding(.vertical, 4)
                }
                .frame(height: 200)
                .listStyle(.plain)
                .padding(.bottom, 30)
            }
        }
    }
}
