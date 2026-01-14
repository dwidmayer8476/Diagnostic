import SwiftUI

struct diagnosticView1: View {
    @State var car = carInfoClass(carVin: "", make: "", year: 0000, carOwner: "")
    
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
                    .textFieldStyle(.roundedBorder)
                
                TextField("enter year", value: $car.year, format: .number)
                    .frame(width: 300, height: 50)
                    .textFieldStyle(.roundedBorder)
                
                TextField("enter owner", text:$car.carOwner)
                    .frame(width: 300, height: 50)
                    .textFieldStyle(.roundedBorder)
                
                Button("Confirm") {
                    print("Confirmed:", car.carVin, car.make, car.year)
                }
                .buttonStyle(.borderedProminent)
                NavigationStack{
                    NavigationLink("Next Page") {
                        diagnosticView2()
                    }
                }
            }
        }
    }
}
