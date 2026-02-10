import SwiftUI

struct diagnosticView1: View {
    @EnvironmentObject var photoStore: PhotoStore
    @EnvironmentObject var printStore: PrintStore
    
    @State var car = carInfoClass(carVin: "", make: "", year: 0, carOwner: "", carGmail: "")
    @State private var yearText: String = ""
    @State private var checkInDate: Date = Date()
    @State private var useExplicitMeridiem: Bool = false
    @State private var meridiemSelection: String = "AM"
    @State private var notes: String = ""
    
    
    var body: some View {
        VStack(alignment: .leading) {
            Text("Car Information")
                .font(.largeTitle)
                .foregroundStyle(.red)
                .frame(maxWidth: .infinity, alignment: .center)
                .padding(.bottom, 40)
            
            
            HStack(alignment: .top, spacing: 80) {
                
                
                VStack(alignment: .leading, spacing: 20) {
                    TextField("Enter VIN", text: $car.carVin)
                        .textFieldStyle(.roundedBorder)
                        .frame(height: 50)
                        .frame(maxWidth: .infinity, alignment: .leading)
                    
                    TextField("Enter Make", text: $car.make)
                        .textFieldStyle(.roundedBorder)
                        .frame(height: 50)
                        .frame(maxWidth: .infinity, alignment: .leading)
                    
                    TextField("Enter Year", text: $yearText)
                        .textFieldStyle(.roundedBorder)
                        .frame(height: 50)
                        .frame(maxWidth: .infinity, alignment: .leading)
                    
                    TextField("Enter Owner", text: $car.carOwner)
                        .textFieldStyle(.roundedBorder)
                        .frame(height: 50)
                        .frame(maxWidth: .infinity, alignment: .leading)
                    TextField("Enter Car Owner's Gmail", text: $car.carGmail)
                        .textFieldStyle(.roundedBorder)
                        .frame(height: 50)
                        .frame(maxWidth: .infinity, alignment: .leading)
                    
                }
                
                VStack(alignment: .leading, spacing: 20) {
                    Text("Check-in Date").font(.caption).foregroundStyle(.secondary).textFieldStyle(.roundedBorder).foregroundStyle(Color.black)
                    DatePicker(
                        "Check-in Date",
                        selection: $checkInDate,
                        displayedComponents: .date
                    )
                    .datePickerStyle(.wheel)
                    .frame(maxWidth: .infinity, alignment: .leading)
                    
                    Text("Check-in Time").font(.caption).foregroundStyle(.secondary).textFieldStyle(.roundedBorder).foregroundStyle(Color.black)
                    DatePicker(
                        "Check-in Time",
                        selection: $checkInDate,
                        displayedComponents: .hourAndMinute
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
                TextField("Enter Notes", text: $notes)
                    .textFieldStyle(.roundedBorder)
                    .frame(maxWidth: .infinity, minHeight: 50, alignment: .leading)
                
                Spacer()
            }
        }
        
        Spacer()
        
        
        HStack(spacing: 30) {
            Button("Confirm") {
                let formatter = DateFormatter()
                formatter.dateStyle = .medium
                formatter.timeStyle = .short
                
                if let parsedYear = Int(yearText.trimmingCharacters(in: .whitespacesAndNewlines)) {
                    car.year = parsedYear
                } else {
                    car.year = 0
                }
                
                if car.year < 0 { car.year = 0 }
                
                let yearDisplay = car.year > 0 ? String(car.year) : "Enter Year"
                let message = """
                                Confirmed Car:
                                VIN: \(car.carVin)
                                Make: \(car.make)
                                Year: \(yearDisplay)
                                Owner: \(car.carOwner)
                                Check-in: \(formatter.string(from: checkInDate))
                                Notes: \(notes)
                                """
                
                printStore.log(message)
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

#Preview {
    diagnosticView1()
        .environmentObject(PhotoStore())
        .environmentObject(PrintStore())
}

