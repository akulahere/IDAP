//
//  Employee.swift
//  IDAP-OOP
//
//  Created by Dmytro Akulinin on 08.05.2023.
//

import Foundation

protocol MoneyContainable: AnyObject {
    
    var money: Money { get set }
}

protocol MoneyTaker: AnyObject {
    
    func take(employee: MoneyContainable, payment: Money)
}

class Employee {
    
    // MARK: -
    // MARK: Variables

    let salary: Money
    let experience: Int
    var money: Money

    // MARK: -
    // MARK: Initializations and Deallocations

    init(salary: Money, experience: Int) {
        self.salary = salary
        self.experience = experience
        self.money = Money(value: 0)
    }
}
