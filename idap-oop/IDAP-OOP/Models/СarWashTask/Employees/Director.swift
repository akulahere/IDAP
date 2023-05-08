//
//  Director.swift
//  IDAP-OOP
//
//  Created by Dmytro Akulinin on 08.05.2023.
//

import Foundation

class Director: Employee, MoneyTaker {
    
    // MARK: -
    // MARK: Private

    private func receive(money: Money) {
        self.money.add(amount: money)
        print("___________________________________________________")
        print("Director collect money")
        print("Director balance: \(self.money.value)")
    }

    // MARK: -
    // MARK: AccountantDelegate

    func take(employee: MoneyContainable, payment: Money) {
        employee.money.subtract(amount: payment)
        self.receive(money: payment)
    }
}
