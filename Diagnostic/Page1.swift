import SwiftUI

struct CarInfo {
    var carVin: String
    var make: String
    var year: String
}

struct diagnosticView1: View {
    @State private var car = CarInfo(carVin: "", make: "", year: "")

    var body: some View {
        VStack(spacing: 20) {

            Text("Car Information")
                .font(.largeTitle)
                .foregroundStyle(.red)

            TextField("Enter VIN", text: $car.carVin)
                .textFieldStyle(.roundedBorder)

            TextField("Enter Make", text: $car.make)
                .textFieldStyle(.roundedBorder)

            TextField("Enter Year", text: $car.year)
                .textFieldStyle(.roundedBorder)
                .keyboardType(.numberPad)

            Button("Confirm") {
                print("Confirmed:", car.carVin, car.make, car.year)
            }
            .buttonStyle(.borderedProminent)
        }
        .padding()
    }
}

#Preview {
    diagnosticView1()
}

