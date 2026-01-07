import SwiftUI

struct diagnosticView1: View {
    @State private var car = carInfoClass(carVin: "", make: "", year: "")
    
    var body: some View {
        NavigationStack {
            VStack(spacing: 20) {
                
                Text("Car Information")
                    .font(.largeTitle)
                    .foregroundStyle(.red)
                
                Button("Enter VIN") {
                    car.carVin = "VIN ENTERED"
                }
                
                Button("Enter Make") {
                    car.make = "MAKE ENTERED"
                }
                
                Button("Enter Year") {
                    car.year = "YEAR ENTERED"
                }
                
                Button("Confirm") {
                    print("Confirmed:", car.carVin, car.make, car.year)
                }
                .buttonStyle(.borderedProminent)
                
                NavigationLink("Next Page") {
                    diagnosticView2()
                }
                .buttonStyle(.bordered)
            }
        }
    }
}
