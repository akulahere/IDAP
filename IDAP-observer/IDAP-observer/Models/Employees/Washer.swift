//
//  Washer.swift
//  IDAP-observer
//
//  Created by Dmytro Akulinin on 08.05.2023.
//

import Foundation


class Washer: Employee, MoneyContainable {
    
    // MARK: -
    // MARK: Variables
    
    var observers : [Weak<Accountant>] = []
    
    // MARK: -
    // MARK: Public
    
    func add(observer: Accountant) {
        self.observers.append(Weak(value: observer))
    }
    
    func process(car: Car) {
        print("___________________________________________________")
        print("Washer has started washing the car")
        wash(car: car)
        let payment = self.collectMoney(from: car)
        
        guard let freeAccounter = self.observers.first?.value else { return }
        
        freeAccounter.update(payment: payment)
        self.money.subtract(amount: payment)
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


