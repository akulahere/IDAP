//
//  Washer.swift
//  IDAP-OOP
//
//  Created by Dmytro Akulinin on 08.05.2023.
//

import Foundation

protocol WasherDelegate: AnyObject {
    func washerDidCollectPayment(_ washer: Washer, payment: Money)
}

class Washer: Employee {
    
    // MARK: -
    // MARK: Variables

    weak var delegate: WasherDelegate?
    
    // MARK: -
    // MARK: Public

    func wash(car: Car) {
        car.isDirty = false
    }
    
    func collectPayment(from car: Car) -> Money {
        let payment = Money(value: 5)
        car.money.subtract(amount: payment)
        self.money.add(amount: payment)
        print("___________________________________________________")
        print("Payment from collected. Ammount: \(payment.value)")
        print("Washer balance: \(self.money.value)")
        print("Car balance: \(car.money.value)")
        return payment
    }
    
    func process(car: Car) {
        print("___________________________________________________")
        print("Washer has started washing the car")
        wash(car: car)
        let payment = collectPayment(from: car)
        delegate?.washerDidCollectPayment(self, payment: payment)
    }
}
