//
//  Accountant.swift
//  IDAP-observer
//
//  Created by Dmytro Akulinin on 08.05.2023.
//

import Foundation

class Accountant:
      Employee,
      MoneyContainable,
      MoneyTaker
{
    
    // MARK: -
    // MARK: Vaiables

    weak var delegate: MoneyTaker?
    
    // MARK: -
    // MARK: Private

    private func calculate(payment: Money) {
        self.money.add(amount: payment)
        self.delegate?.take(employee: self, payment: payment)
        print("___________________________________________________")
        print("Accountant collect money from washer")
        print("Accountant balance: \(self.money.value)")
    }

    
    // MARK: -
    // MARK: MoneyTaker
    func take(employee: MoneyContainable, payment: Money) {
        employee.money.subtract(amount: payment)
        self.calculate(payment: payment)
    }
}

