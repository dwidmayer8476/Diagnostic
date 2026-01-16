import SwiftUI

struct diagnosticView1: View {
    @State var car = carInfoClass(carVin: "", make: "", year: 0000, carOwner: "")
    @State private var checkInDate: Date = Date()
    @State private var useExplicitMeridiem: Bool = false
    @State private var meridiemSelection: String = "AM"
    
    var body: some View {
        VStack {
            Text("Car Information")
                .font(.largeTitle)
                .foregroundStyle(.red)
                .padding(.bottom, 20)
            
            
            HStack(alignment: .top, spacing: 60) {
                
                
                VStack(spacing: 20) {
                    TextField("Enter VIN", text: $car.carVin)
                        .frame(width: 300, height: 50)
                        .textFieldStyle(.roundedBorder)
                    
                    TextField("Enter Make", text: $car.make)
                        .frame(width: 300, height: 50)
                        .textFieldStyle(.roundedBorder)
                    
                    TextField("Enter Year", value: $car.year, format: .number)
                        .frame(width: 300, height: 50)
                        .textFieldStyle(.roundedBorder)
                    
                    TextField("Enter Owner", text: $car.carOwner)
                        .frame(width: 300, height: 50)
                        .textFieldStyle(.roundedBorder)
                }
                
                VStack(spacing: 20) {
                    DatePicker(
                        "Check-in Date",
                        selection: $checkInDate,
                        displayedComponents: .date
                    )
                    .datePickerStyle(.wheel)
                    .frame(width: 250)
                    
                    DatePicker(
                        "Check-in Time",
                        selection: $checkInDate,
                        displayedComponents: .hourAndMinute
                    )
                    .datePickerStyle(.wheel)
                    .frame(width: 250)
                    
                    if useExplicitMeridiem {
                        Picker("AM/PM", selection: $meridiemSelection) {
                            Text("AM").tag("AM")
                            Text("PM").tag("PM")
                        }
                        .pickerStyle(.segmented)
                        .frame(width: 200)
                    }
                }
            }
            
            Spacer()
            
            
            HStack(spacing: 30) {
                Button("Confirm") {
                    let formatter = DateFormatter()
                    formatter.dateStyle = .medium
                    formatter.timeStyle = .short
                    print(
                        "Confirmed:",
                        car.carVin,
                        car.make,
                        car.year,
                        formatter.string(from: checkInDate)
                    )
                }
                .buttonStyle(.borderedProminent)
                
                NavigationLink("Next Page") {
                    diagnosticView2()
                }
                .buttonStyle(.bordered)
            }
            .padding(.bottom, 30)
        }
        .padding()
    }
}
