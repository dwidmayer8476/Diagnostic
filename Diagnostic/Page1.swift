import SwiftUI

struct diagnosticView1: View {
    @EnvironmentObject var photoStore: PhotoStore
    
    @State var car = carInfoClass(carVin: "", make: "", year: 0000, carOwner: "")
    @State private var showCamera = false
    
    var body: some View {
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

            Text("")

            Button("Take Photo for Page 1") {
                showCamera = true
            }
            .buttonStyle(.bordered)

            NavigationLink("Next Page") {
                diagnosticView2()
            }
        }
        .padding()
        .sheet(isPresented: $showCamera) {
            CameraPicker(images: .constant([])) { captured in
                photoStore.imagesByKey["page1"] = captured
            }
        }
    }
}

