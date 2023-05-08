//
//  Director.swift
//  IDAP-OOP
//
//  Created by Dmytro Akulinin on 08.05.2023.
//

import Foundation

class Director: Employee, AccountantDelegate {
    
    // MARK: -
    // MARK: Public

    func receive(money: Money) {
        self.money.add(amount: money)
        print("___________________________________________________")
        print("Director collect money")
        print("Director balance: \(self.money.value)")
    }

    // MARK: -
    // MARK: AccountantDelegate

    func accountantDidCalculateMoney(_ accountant: Accountant, payment: Money) {
        accountant.money.subtract(amount: payment)
        receive(money: payment)
    }
}
