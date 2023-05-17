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
    
    var name: String?
    let salary: Money
    let experience: Int
    var money: Money
    var state: WorkerState
    var observers: [ObserverProtocol] = []
    
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
    
    func processInMainThread(processable: T) {
        // to be overridden by subclass
    }
    
    func processInBackgroundThread(processable: T) {
        // to be overridden by subclass
    }
    
    final func startProcessing(processable: T) {
        self.state = .working
        DispatchQueue.global(qos: .background).async {
            self.processInBackgroundThread(processable: processable)
            self.state = .needsProcessing

            DispatchQueue.main.async {
                self.state = .ready
                self.processInMainThread(processable: processable)
                // notify observers
            }
        }
    }
    
    func add(observer: ObserverProtocol) {
        self.observers.append(observer)
    }
}
