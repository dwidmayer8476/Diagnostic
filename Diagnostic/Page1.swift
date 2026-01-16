import SwiftUI

struct diagnosticView1: View {
    @State var car = carInfoClass(carVin: "", make: "", year: 0000, carOwner: "")
    @State private var checkInDate: Date = Date()
    @State private var useExplicitMeridiem: Bool = false
    @State private var meridiemSelection: String = "AM"
    var body: some View {
        HStack{
            VStack(spacing: 20) {
                
                Text("Car Information")
                    .font(.largeTitle)
                    .foregroundStyle(.red)
                
                TextField("Enter Vin", text: $car.carVin)
                    .frame(width: 300, height: 50)
                    .textFieldStyle(.roundedBorder)
                
                TextField("Enter Make", text: $car.make)
                    .frame(width: 300, height: 50)
                    .textFieldStyle(.roundedBorder)
                
                TextField("Enter Year", value: $car.year, format: .number)
                    .frame(width: 300, height: 50)
                    .textFieldStyle(.roundedBorder)
                
                TextField("Enter Owner", text:$car.carOwner)
                    .frame(width: 300, height: 50)
                    .textFieldStyle(.roundedBorder)
                
                DatePicker("Check-in Date", selection: $checkInDate, displayedComponents: .date)
                    .datePickerStyle(.wheel)
                    .frame(width: 300)
                
                DatePicker("Check-in Time", selection: $checkInDate, displayedComponents: .hourAndMinute)
                    .datePickerStyle(.wheel)
                    .frame(width: 300)
                
                // Optional explicit AM/PM control; set useExplicitMeridiem to true to show
                if useExplicitMeridiem {
                    Picker("AM/PM", selection: $meridiemSelection) {
                        Text("AM").tag("AM")
                        Text("PM").tag("PM")
                    }
                    .pickerStyle(.segmented)
                    .frame(width: 300)
                }
                
                Button("Confirm") {
                    let formatter = DateFormatter()
                    formatter.dateStyle = .medium
                    formatter.timeStyle = .short
                    print("Confirmed:", car.carVin, car.make, car.year, formatter.string(from: checkInDate))
                }
                .buttonStyle(.borderedProminent)
                
                NavigationLink("Next Page") {
                    diagnosticView2()
                }
            }
        }
    }
}

