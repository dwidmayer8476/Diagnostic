
import SwiftUI

struct diagnosticView1: View {
    @State var car = carInfoClass(carVin: "", make: "", year: "")
    var body: some View {
       Text("Hello, World!")
        VStack{
            TextField("Enter Vin", text: $car.carVin )
            TextField("Enter make", text: $car.make )
            TextField("Enter year", text: $car.year )
            
        }
        Text("Vin is \(car.carVin)")
        Text("Make is \(car.make)")
        Text("year is \(car.year)")
       
        Button("Confirm?") {
            
        }
        .font(.largeTitle)
        .foregroundStyle(.red)
        }
    }
#Preview {
    diagnosticView1()
}
