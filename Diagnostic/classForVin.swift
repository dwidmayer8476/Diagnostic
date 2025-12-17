//
//  classForVin.swift
//  Diagnostic
//
//  Created by Dylan J. Widmayer on 12/17/25.
//
import SwiftUI

struct carInfoClass: Identifiable{
    let id = UUID()
    var carVin:String
    var make:String
    var year:String
    
    init(carVin: String, make: String, year: String) {
        self.carVin = carVin
        self.make = make
        self.year = year
    }
}
