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

struct DiagnosticView1: View {
    @EnvironmentObject var photoStore: PhotoStore
    @EnvironmentObject var printStore: PrintStore
    @StateObject private var reportStore = ReportStore()
    
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
    @State private var goNext: Bool = false
    
    private func inputCard<Content: View>(title: String, systemImage: String, @ViewBuilder content: () -> Content) -> some View {
        VStack(alignment: .leading, spacing: 16) {
            HStack(spacing: 10) {
                Image(systemName: systemImage)
                    .font(.title3)
                    .foregroundStyle(Color.accentColor)
                Text(title)
                    .font(.headline)
                    .foregroundStyle(.primary)
            }
            content()
        }
        .padding(16)
        .background(.thinMaterial, in: RoundedRectangle(cornerRadius: 16, style: .continuous))
        .shadow(color: Color.black.opacity(0.08), radius: 12, x: 0, y: 6)
    }
    
    var body: some View {
        ZStack {
            LinearGradient(colors: [Color(.systemBackground), Color(.secondarySystemBackground)], startPoint: .top, endPoint: .bottom)
                .ignoresSafeArea()
            
            ScrollView {
                VStack(spacing: 24) {
                    VStack(spacing: 8) {
                        Text("Car Information")
                            .font(.largeTitle.bold())
                            .foregroundStyle(.primary)
                            .frame(maxWidth: .infinity, alignment: .leading)
                        Text("Enter details to check in a vehicle and capture notes.")
                            .font(.subheadline)
                            .foregroundStyle(.secondary)
                            .frame(maxWidth: .infinity, alignment: .leading)
                    }
                    .padding(.horizontal)
                    .padding(.top, 8)
                    
                    inputCard(title: "Vehicle Details", systemImage: "car.fill") {
                        VStack(spacing: 12) {
                            LabeledContent("VIN") {
                                TextField("1HGCM82633A004352", text: $carVin)
                                    .textFieldStyle(.roundedBorder)
                                    .textInputAutocapitalization(.characters)
                                    .autocorrectionDisabled()
                                    .font(.body)
                                    .frame(maxWidth: 480)
                            }
                            LabeledContent("Make") {
                                TextField("e.g. Toyota", text: $make)
                                    .textFieldStyle(.roundedBorder)
                                    .autocorrectionDisabled()
                                    .font(.body)
                                    .frame(maxWidth: 480)
                            }
                            LabeledContent("Year") {
                                TextField("e.g. 2018", text: $yearText)
                                    .keyboardType(.numberPad)
                                    .textFieldStyle(.roundedBorder)
                                    .font(.body)
                                    .frame(maxWidth: 200)
                            }
                        }
                    }
                    .padding(.horizontal)
                    
                    inputCard(title: "Owner", systemImage: "person.crop.circle.fill") {
                        VStack(spacing: 12) {
                            LabeledContent("Name") {
                                TextField("Owner name", text: $carOwner)
                                    .textFieldStyle(.roundedBorder)
                                    .font(.body)
                                    .frame(maxWidth: 480)
                            }
                            LabeledContent("Gmail") {
                                TextField("owner@gmail.com", text: $carGmail)
                                    .textFieldStyle(.roundedBorder)
                                    .textInputAutocapitalization(.never)
                                    .keyboardType(.emailAddress)
                                    .autocorrectionDisabled()
                                    .font(.body)
                                    .frame(maxWidth: 480)
                            }
                        }
                    }
                    .padding(.horizontal)
                    
                    inputCard(title: "Check-in", systemImage: "calendar.badge.clock") {
                        VStack(spacing: 12) {
                            LabeledContent("Date") {
                                DatePicker("Date", selection: $checkInDate, displayedComponents: .date)
                                    .datePickerStyle(.compact)
                                    .labelsHidden()
                            }
                            LabeledContent("Time") {
                                HStack(spacing: 12) {
                                    DatePicker("Time", selection: $checkInDate, displayedComponents: .hourAndMinute)
                                        .datePickerStyle(.compact)
                                        .labelsHidden()
                                    if useExplicitMeridiem {
                                        Picker("AM/PM", selection: $meridiemSelection) {
                                            Text("AM").tag("AM")
                                            Text("PM").tag("PM")
                                        }
                                        .pickerStyle(.segmented)
                                        .frame(maxWidth: 180)
                                    }
                                }
                            }
                        }
                    }
                    .padding(.horizontal)
                    
                    inputCard(title: "Student Notes", systemImage: "note.text") {
                        VStack(spacing: 12) {
                            TextField("Enter notes...", text: $notes, axis: .vertical)
                                .textFieldStyle(.roundedBorder)
                                .lineLimit(3, reservesSpace: true)
                                .frame(minHeight: 60)
                                .font(.body)
                        }
                    }
                    .padding(.horizontal)
                    
                    // Footer button
                    VStack {
                        Button(action: confirmAction) {
                            HStack {
                                Image(systemName: "checkmark.circle.fill")
                                Text("Confirm")
                                    .fontWeight(.semibold)
                            }
                            .frame(maxWidth: .infinity)
                        }
                        .buttonStyle(.borderedProminent)
                        .tint(.accentColor)
                        .controlSize(.large)
                        .padding(.horizontal)
                    }
                    .padding(.bottom, 24)
                }
            }
        }
        .navigationDestination(isPresented: $goNext) {
            diagnosticView2()
        }
    }
    
    private func confirmAction() {
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
        
        // clear form
        carVin = ""
        make = ""
        yearText = ""
        carOwner = ""
        carGmail = ""
        notes = ""
        checkInDate = Date()
        useExplicitMeridiem = false
        meridiemSelection = "AM"
        
        // navigate to next page
        goNext = true
    }
}

struct DiagnosticView1_Previews: PreviewProvider {
    static var previews: some View {
        NavigationStack {
            DiagnosticView1()
        }
        .environmentObject(PhotoStore())
        .environmentObject(PrintStore())
    }
}
