//
//  Employee.swift
//  IDAP-observer
//
//  Created by Dmytro Akulinin on 08.05.2023.
//

import Foundation

enum WorkerState {
    case ready
    case working
    case needsProcessing
}

class Employee<T> {
    
    // MARK: -
    // MARK: Variables
    
    var name: String
    let salary: Money
    let experience: Int
    var money: Money
    var state: WorkerState
    
    // MARK: -
    // MARK: Initializations and Deallocations
    
    init(salary: Money, experience: Int, name: String = "Default name") {
        self.name = name
        self.salary = salary
        self.experience = experience
        self.money = Money(value: 0)
        self.state = .ready
    }
}
