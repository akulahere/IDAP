//
//  Director.swift
//  IDAP-observer
//
//  Created by Dmytro Akulinin on 08.05.2023.
//

import Foundation

class Director: Employee, EmployeeObserver {
    
    // MARK: -
    // MARK: Public
    
    func update(payment: Money) {
        self.receive(money: payment)
    }

    // MARK: -
    // MARK: Private

    private func receive(money: Money) {
        self.money.add(amount: money)
        print("___________________________________________________")
        print("Director collect money")
        print("Director balance: \(self.money.value)")
    }
}
