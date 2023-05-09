//
//  Accountant.swift
//  IDAP-observer
//
//  Created by Dmytro Akulinin on 08.05.2023.
//

import Foundation

class Accountant: Employee, MoneyContainable {
    
    // MARK: -
    // MARK: Vaiables
    
    weak var observer: Director?
    
    // MARK: -
    // MARK: Public
    
    func add(observer: Director) {
        self.observer = observer
    }

    func update(payment: Money) {
        self.calculate(payment: payment)
    }
    
    // MARK: -
    // MARK: Private

    private func calculate(payment: Money) {
        self.money.add(amount: payment)
        print("___________________________________________________")
        print("Accountant collect money from washer")
        print("Accountant balance: \(self.money.value)")
        self.observer?.update( payment: payment)
        self.money.subtract(amount: payment)
    }
}
