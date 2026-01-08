import SwiftUI

struct diagnosticView1: View {
    @State private var car = carInfoClass(carVin: "", make: "", year: "")
    
    var body: some View {
        VStack(spacing: 20) {
            
            Text("Car Information")
                .font(.largeTitle)
                .foregroundStyle(.red)
            
           TextField("enter vin", text: $car.carVin)
            
            
            TextField("enter make", text: $car.make)
            
            TextField("enter year ", text: $car.year)
            Button("Confirm") {
                print("Confirmed:", car.carVin, car.make, car.year)
            }
            .buttonStyle(.borderedProminent)
        }
        .padding()
    }
}

#Preview {
    diagnosticView2()
}
