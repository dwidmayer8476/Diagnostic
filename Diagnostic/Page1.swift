
import SwiftUI

struct diagnosticView1: View {
    @State var status = statusClass(red: false, yellow: false, green: false)
    var body: some View {
       Text("Hello, World!")
        VStack{
//            TextField("Red", text: $status.red )
//            TextField("Yellow", text: $status.yellow )
//            TextField("Green", text: $status.green )
            
          
        }
        Button("red") {
            status.red = true
            status.yellow = false
            status.green = false
        }
        Button("yellow") {
            status.red = false
            status.yellow = true
            status.green = false
        }
        Button("green") {
            status.red = false
            status.yellow = false
            status.green = true
        }


       
        Button("Confirm?") {
            
        }
        .font(.largeTitle)
        .foregroundStyle(.red)
        }
    }
#Preview {
    diagnosticView1()
}
