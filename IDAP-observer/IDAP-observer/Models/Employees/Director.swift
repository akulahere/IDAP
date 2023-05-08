//
//  Director.swift
//  IDAP-observer
//
//  Created by Dmytro Akulinin on 08.05.2023.
//

import Foundation

class Director: Employee, EmployeeObserver {
    
    // MARK: -
    // MARK: Private

    private func receive(money: Money) {
        self.money.add(amount: money)
        print("___________________________________________________")
        print("Director collect money")
        print("Director balance: \(self.money.value)")
    }

    func update(employee: MoneyContainable, payment: Money) {
        employee.money.subtract(amount: payment)
        self.receive(money: payment)
    }

}

