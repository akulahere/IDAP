//
//  Washer.swift
//  IDAP-OOP
//
//  Created by Dmytro Akulinin on 08.05.2023.
//

import Foundation

class Washer:
    Employee,
    MoneyContainable
{
    
    // MARK: -
    // MARK: Variables
    
    weak var delegate: MoneyTaker?
    
    // MARK: -
    // MARK: Public
    
    func process(car: Car) {
        print("___________________________________________________")
        print("Washer has started washing the car")
        wash(car: car)
        let payment = collectMoney(from: car)
        self.delegate?.take(employee: self, payment: payment)
    }
    
    // MARK: -
    // MARK: Private
    
    private func wash(car: Car) {
        car.isDirty = false
    }
    
    private func collectMoney(from car: Car) -> Money {
        let washPrice = Double.random(in: 1...10).rounded()
        let payment = Money(value: washPrice)
        car.money.subtract(amount: payment)
        self.money.add(amount: payment)
        print("___________________________________________________")
        print("Payment from collected. Ammount: \(payment.value)")
        print("Washer balance: \(self.money.value)")
        print("Car balance: \(car.money.value)")
        return payment
    }
}
