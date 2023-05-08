//
//  WasherController.swift
//  IDAP-OOP
//
//  Created by Dmytro Akulinin on 08.05.2023.
//

import Foundation

class WasherController: MoneyContainable {
    
    // MARK: -
    // MARK: Variables
    
    private var model: Washer
    private let view: WasherView = WasherView()
    weak var delegate: MoneyTaker?
    var isFree: Bool = true
    
    // MARK: -
    // MARK: Initializations and Deallocations

    init(salary: Double, experience: Int) {
        let model = Washer(salary: salary, experience: 3)
        self.model = model
    }
    
    // MARK: -
    // MARK: Public
    
    func process(car: Car) {
        view.start()
        wash(car: car)
        let payment = collectMoney(from: car)
        self.delegate?.take(employee: self, payment: payment)
        self.isFree = true
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
        self.model.money.add(amount: payment)
        self.view.show(
            amount: payment.value,
            washerBalance: self.model.money.value,
            carBalance: car.money.value
        )

        return payment
    }
    
    // MARK: -
    // MARK: MoneyContainable
    
    func give(money: Money) {
        self.model.money.subtract(amount: money)
    }
}
