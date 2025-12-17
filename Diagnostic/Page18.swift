//import SwiftUI
//import FirebaseFirestore
//
//struct HeaderView: View {
//    @State var enteredCollege: String = ""
//    @State var enteredCollegeLocation: String = ""
//    @Environment(CBPViewModel.self) var viewModel
//    var body: some View {
//        HStack{
//            TextField("Enter College", text: $enteredCollege)
//            .textFieldStyle(RoundedBorderTextFieldStyle())
//            TextField("Enter Location", text: $enteredCollegeLocation)
//            .textFieldStyle(RoundedBorderTextFieldStyle())
//                
//            Button("+") {
//                viewModel.addCollege(collegeName: enteredCollege, collegeLocation: enteredCollegeLocation)
//                enteredCollege = ""
//                enteredCollegeLocation = ""
//            }
//            .font(.largeTitle)
//        }
//        .padding()
//    }
//}
