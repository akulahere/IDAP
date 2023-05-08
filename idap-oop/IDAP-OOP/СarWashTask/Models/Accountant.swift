//
//  Accountant.swift
//  IDAP-OOP
//
//  Created by Dmytro Akulinin on 08.05.2023.
//

import Foundation

class Accountant: Employee {
    
    // MARK: -
    // MARK: Variables

    var money: Money
    
    // MARK: -
    // MARK: Initializations and Deallocations

    init(salary: Double, experience: Int, money: Double = 0) {
        self.money = Money(value: money)
        super.init(salary: salary, experience: experience)
    }
}
