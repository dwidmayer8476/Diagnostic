//
//  File.swift
//  Diagnostic
//
//  Created by Nicholas C. Wiesneth on 12/17/25.
//


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