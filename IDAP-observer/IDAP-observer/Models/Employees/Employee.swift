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


class Employee {
    
    // MARK: -
    // MARK: Variables
    
    var name: String?
    let salary: Money
    let experience: Int
    var money: Money
    var state: WorkerState
    
    // MARK: -
    // MARK: Initializations and Deallocations

    init(salary: Money, experience: Int) {
        self.salary = salary
        self.experience = experience
        self.money = Money(value: 0)
        self.state = .ready
    }
    
    // MARK: -
    // MARK: Public
    
    func processInMainThread() {
        // to be overridden by subclass
    }
    
    func processInBackgroundThread() {
        // to be overridden by subclass
    }
    
    final func startProcessing() {
        self.state = .working
        DispatchQueue.global(qos: .background).async {
            self.processInBackgroundThread()
            DispatchQueue.main.async {
                self.state = .needsProcessing
                self.processInMainThread()
                self.state = .ready
                // notify observers
            }
        }
    }
}
