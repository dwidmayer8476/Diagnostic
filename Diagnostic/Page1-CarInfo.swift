import SwiftUI

struct diagnosticView1: View {
    @State private var car = carInfoClass(carVin: "", make: "", year: "", carOwner: "")
    
    var body: some View {
        HStack{
            VStack(spacing: 20) {
                
                Text("Car Information")
                    .font(.largeTitle)
                    .foregroundStyle(.red)
                
                TextField("enter vin", text: $car.carVin)
                    .frame(width: 300, height: 50)
                    .textFieldStyle(.roundedBorder)
                
                TextField("enter make", text: $car.make)
                    .frame(width: 300, height: 50)
                
                TextField("enter year ", text: $car.year)
                    .frame(width: 300, height: 50
                    )
                Button("Confirm") {
                    print("Confirmed:", car.carVin, car.make, car.year)
                }
                .buttonStyle(.borderedProminent)
                
                NavigationLink("Next Page") {
                    diagnosticView3()
                }
            }
        }
    }   
}
