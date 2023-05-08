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
      EmployeeObserver
{
    
    // MARK: -
    // MARK: Vaiables
    
    var observers: [EmployeeObserver] = []

    
    // MARK: -
    // MARK: Public
    
    func add(observer: EmployeeObserver) {
        observers.append(observer)
    }

    // MARK: -
    // MARK: Private

    private func calculate(payment: Money) {
        self.money.add(amount: payment)
        print("___________________________________________________")
        print("Accountant collect money from washer")
        print("Accountant balance: \(self.money.value)")
        observers.forEach { observer in
            observer.update(employee: self, payment: payment)
        }
    }

    // MARK: -
    // MARK: EmployeeObserver
    
    func update(employee: MoneyContainable, payment: Money) {
        employee.money.subtract(amount: payment)
        self.calculate(payment: payment)
    }
}

