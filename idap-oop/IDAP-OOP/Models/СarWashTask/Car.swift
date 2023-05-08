//
//  Car.swift
//  IDAP-observer
//
//  Created by Dmytro Akulinin on 08.05.2023.
//

import Foundation

class Car {
    
    // MARK: -
    // MARK: Variables

    var isDirty: Bool
    var money: Money
    
    // MARK: -
    // MARK: Initializations and Deallocations

    init(isDirty: Bool, money: Double) {
        self.isDirty = isDirty
        self.money = Money(value: money)
    }
}
