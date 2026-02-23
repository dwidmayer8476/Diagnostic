//
//  CarMap.swift
//  Diagnostic
//
//  Created by Dylan J. Widmayer on 2/23/26.
//
import SwiftUI

struct CarMap: View {
    var body: some View {
        Image("Carmap")
            .resizable()
            .scaledToFit()
            .frame(maxWidth: .infinity, maxHeight: .infinity)
            .ignoresSafeArea()
    }
}
#Preview {
    CarMap()
}
