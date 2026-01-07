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
struct statusClass: Identifiable {
    let id = UUID()
    var red:Bool
    var yellow:Bool
    var green:Bool
    
    init(red: Bool, yellow: Bool, green: Bool) {
        self.red = red
        self.yellow = yellow
        self.green = green
    }
}
