import SwiftUI
import Combine

//date for the cars info
struct CarReport: Identifiable, Codable {
    let id: UUID
    var carVin: String
    var make: String
    var year: Int
    var carOwner: String
    var carGmail: String
    var checkInDate: Date
    var notes: String
    
    init(id: UUID = UUID(), carVin: String, make: String, year: Int, carOwner: String, carGmail: String, checkInDate: Date, notes: String) {
        self.id = id
        self.carVin = carVin
        self.make = make
        self.year = year
        self.carOwner = carOwner
        self.carGmail = carGmail
        self.checkInDate = checkInDate
        self.notes = notes
    }
}


class ReportStore: ObservableObject {
    @Published var reports: [CarReport] = [] {
        didSet {
            save()
        }
    }
    
    private let userDefaultsKey = "CarReports"
    
    init() {
        load()
    }
    
    func load() {
        guard let data = UserDefaults.standard.data(forKey: userDefaultsKey) else {
            reports = []
            return
        }
        do {
            let decoder = JSONDecoder()
            reports = try decoder.decode([CarReport].self, from: data)
        } catch {
            print("Failed to load reports: \(error)")
            reports = []
        }
    }
    
    func save() {
        do {
            let encoder = JSONEncoder()
            let data = try encoder.encode(reports)
            UserDefaults.standard.set(data, forKey: userDefaultsKey)
        } catch {
            print("Failed to save reports: \(error)")
        }
    }
}

struct diagnosticView1: View {
    @EnvironmentObject var photoStore: PhotoStore
    @EnvironmentObject var printStore: PrintStore
    @StateObject var reportStore = ReportStore()
    
    // inputs for buttons
    @State private var carVin: String = ""
    @State private var make: String = ""
    @State private var yearText: String = ""
    @State private var carOwner: String = ""
    @State private var carGmail: String = ""
    @State private var checkInDate: Date = Date()
    @State private var notes: String = ""
    @State private var useExplicitMeridiem: Bool = false
    @State private var meridiemSelection: String = "AM"
    
    
    var body: some View {
        VStack(alignment: .leading) {
            Text("Car Information")
                .font(.largeTitle)
                .foregroundStyle(.red)
                .frame(maxWidth: .infinity, alignment: .center)
                .padding(.bottom, 40)
            
            //Past Reports
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
            
            HStack(alignment: .top, spacing: 80) {
                VStack(alignment: .center, spacing: 15) {
                    TextField("Enter VIN", text: $carVin)
                        .textFieldStyle(.roundedBorder)
                        .frame(width: 200, height: 45)
                        .frame(maxWidth: .infinity, alignment: .center)
                    
                    TextField("Enter Make", text: $make)
                        .textFieldStyle(.roundedBorder)
                        .frame(width: 200, height: 45)
                        .frame(maxWidth: .infinity, alignment: .center)
                    
                    TextField("Enter Year", text: $yearText)
                        .textFieldStyle(.roundedBorder)
                        .frame(width: 200, height: 45)
                        .frame(maxWidth: .infinity, alignment: .center)
                    
                    TextField("Enter Owner", text: $carOwner)
                        .textFieldStyle(.roundedBorder)
                        .frame(width: 200, height: 45)
                        .frame(maxWidth: .infinity, alignment: .center)
                    
                    TextField("Enter Car Owner's Gmail", text: $carGmail)
                        .textFieldStyle(.roundedBorder)
                        .frame(width: 200, height: 45)
                        .frame(maxWidth: .infinity, alignment: .center)
                }
                .frame(maxWidth: .infinity, alignment: .center)
                
                VStack(alignment: .leading, spacing: 20) {
                    Text("Check-in Date")
                        .font(.title3).textFieldStyle(.roundedBorder)
                        .foregroundStyle(Color.black)
                        .frame(maxWidth: .infinity, alignment: .center)
                    DatePicker(
                        "Check-in Date",
                        selection: $checkInDate,
                        displayedComponents: .date
                    )
                    .datePickerStyle(.wheel)
                    .frame(maxWidth: .infinity, alignment: .leading)
                    
                    Text("Check-in Time")
                        .font(.title3)
                        .textFieldStyle(.roundedBorder)
                        .foregroundStyle(Color.black)
                        .frame(maxWidth: .infinity, alignment: .center)
                    DatePicker(
                        "Check-in Time",
                        selection: $checkInDate,
                        displayedComponents:.hourAndMinute
                    )
                    .datePickerStyle(.wheel)
                    .frame(maxWidth: .infinity, alignment: .leading)
                    
                    if useExplicitMeridiem {
                        Picker("AM/PM", selection: $meridiemSelection) {
                            Text("AM").tag("AM")
                            Text("PM").tag("PM")
                        }
                        .pickerStyle(.segmented)
                        .frame(maxWidth: .infinity, alignment: .leading)
                    }
                }
                VStack(alignment: .center, spacing: 8) {
                    Text("Student Notes")
                        .font(.title3)
                        .foregroundStyle(Color.black)
                        .frame(maxWidth: .infinity, alignment: .center)
                    TextField("Enter Notes", text: $notes)
                        .textFieldStyle(.roundedBorder)
                        .frame(width: 300, height: 50)
                        .frame(maxWidth: .infinity, alignment: .center)
                }
                .frame(maxWidth: .infinity)
                Spacer()
            }
        }
        
        Spacer()
        
        
        HStack(spacing: 30) {
            Button("Confirm") {
                let formatter = DateFormatter()
                formatter.dateStyle = .medium
                formatter.timeStyle = .short
                
                let timeFormatter = DateFormatter()
                timeFormatter.dateStyle = .none
                timeFormatter.timeStyle = .short
                
                if let parsedYear = Int(yearText.trimmingCharacters(in: .whitespacesAndNewlines)) {
                    car.year = parsedYear
                } else {
                    car.year = 0
                }
                
                if car.year < 0 { car.year = 0 }
                
                let message = """
                                Confirmed Car:
                                VIN: \(car.carVin)
                                Make: \(car.make)
                                Year: \(car.year)
                                Owner: \(car.carOwner)
                                Check-in Date: \(formatter.string(from: checkInDate))
                                Check-in Time: \(timeFormatter.string(from: checkInDate))
                                Notes: \(notes)
                                """
                
                printStore.log(message, for: "CarInfo")
            }
            .buttonStyle(.borderedProminent)
            
            HStack(spacing: 30) {
                Button("Confirm") {
                    let formatter = DateFormatter()
                    formatter.dateStyle = .medium
                    formatter.timeStyle = .short
                    
                    var parsedYear = 0
                    if let yearInt = Int(yearText.trimmingCharacters(in: .whitespacesAndNewlines)) {
                        parsedYear = yearInt
                    }
                    if parsedYear < 0 { parsedYear = 0 }
                    
                    let newReport = CarReport(
                        carVin: carVin,
                        make: make,
                        year: parsedYear,
                        carOwner: carOwner,
                        carGmail: carGmail,
                        checkInDate: checkInDate,
                        notes: notes
                    )
                    
                    reportStore.reports.append(newReport)
                    reportStore.save()
                    
                    let message = """
                    Confirmed Car:
                    VIN: \(carVin)
                    Make: \(make)
                    Year: \(parsedYear)
                    Owner: \(carOwner)
                    Check-in: \(formatter.string(from: checkInDate))
                    Notes: \(notes)
                    """
                    printStore.log(message, for: "CarInfo")
                    
                    
                    carVin = ""
                    make = ""
                    yearText = ""
                    carOwner = ""
                    carGmail = ""
                    notes = ""
                    checkInDate = Date()
                    useExplicitMeridiem = false
                    meridiemSelection = "AM"
                }
                .buttonStyle(.borderedProminent)
                
                NavigationLink("Next Page") {
                    diagnosticView2()
                }
                .buttonStyle(.bordered)
            }
            .padding(.bottom, 30)
        }
    }
}

#Preview {
    diagnosticView1()
        .environmentObject(PhotoStore())
        .environmentObject(PrintStore())
        .environmentObject(ReportStore())
}

