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
    
    var observers : [Weak<Director>] = []

    // MARK: -
    // MARK: Public
    
    func add(observer: Director) {
        self.observers.append(Weak(value: observer))
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
        
        guard let freeDirector = self.observers.first?.value else { return }
        
        freeDirector.update(payment: payment)
        self.money.subtract(amount: payment)
    }
}
