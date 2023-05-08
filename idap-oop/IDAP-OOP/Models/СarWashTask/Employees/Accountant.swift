//
//  Accountant.swift
//  IDAP-OOP
//
//  Created by Dmytro Akulinin on 08.05.2023.
//

import Foundation

protocol AccountantDelegate: AnyObject {
    func accountantDidCalculateMoney(_ accountant: Accountant, payment: Money)
}

class Accountant: Employee, WasherDelegate {
    
    // MARK: -
    // MARK: Vaiables

    weak var delegate: AccountantDelegate?
    
    // MARK: -
    // MARK: Public

    func calculate(payment: Money) {
        self.money.add(amount: payment)
        delegate?.accountantDidCalculateMoney(self, payment: payment)
        print("___________________________________________________")
        print("Accountant collect money from washer")
        print("Accountant balance: \(self.money.value)")
    }

    
    // MARK: -
    // MARK: WasherDelegate

    func washerDidCollectPayment(_ washer: Washer, payment: Money) {
        washer.money.subtract(amount: payment)
        calculate(payment: payment)
    }
}
