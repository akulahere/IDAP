//
//  Employee.swift
//  IDAP-OOP
//
//  Created by Dmytro Akulinin on 08.05.2023.
//

import Foundation

class Employee {
    
    // MARK: -
    // MARK: Variables

    let salary: Money
    let experience: Int

    // MARK: -
    // MARK: Initializations and Deallocations

    init(salary: Double, experience: Int) {
        self.salary = Money(value: salary)
        self.experience = experience
    }
}
