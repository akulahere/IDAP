//
//  CarWash.swift
//  IDAP-observer
//
//  Created by Dmytro Akulinin on 08.05.2023.
//

import Foundation

class CarWash {

     // MARK: -
     // MARK: Variables

     let washers: [Washer]
     let accountant: Accountant
     let director: Director

     // MARK: -
     // MARK: Initializations and Deallocations

     init(washers: [Washer], accountant: Accountant, director: Director) {
         self.washers = washers
         self.accountant = accountant
         self.director = director

         self.washers.forEach { washer in
             washer.add(observer: self.accountant)
         }
         self.accountant.add(observer: self.director)
     }

     // MARK: -
     // MARK: Public

     func wash(car: Car) {
         guard let washer = self.washers.first(where: { $0.money.value == 0 }) else {
             print("No free washers")
             return
         }
         print("Car wash set a cat to the washer")
         washer.process(car: car)
     }
 }
