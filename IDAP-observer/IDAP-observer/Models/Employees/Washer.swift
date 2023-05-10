//
//  Washer.swift
//  IDAP-observer
//
//  Created by Dmytro Akulinin on 08.05.2023.
//

import Foundation


class Washer: Employee {
    
    // MARK: -
    // MARK: Variables
    
    var car: Car?
    var accountantObservers = ThreadSafeObservers<Accountant>()
    var carWashObservers = ThreadSafeObservers<CarWash>()
    
    // MARK: -
    // MARK: Public
    
    func add(observer: Accountant) {
        self.accountantObservers.add(observer: observer)
    }
    
    func add(observer: CarWash) {
        self.carWashObservers.add(observer: observer)
    }
    
    // MARK: -
    // MARK: Private
    
    private func wash() {
        guard let car = self.car else { fatalError("No car!") }
        sleep(UInt32(self.experience))
        car.isDirty = false
    }
    
    private func collect() {
        let washPrice = Double.random(in: 1...10).rounded()
        let payment = Money(value: washPrice)
        self.car?.money.subtract(amount: payment)
        self.money.add(amount: payment)
    }

    // MARK: -
    // MARK: Overrided

    override func processInMainThread() {
        let moneyToNotify = self.money
        self.carWashObservers.notify(with: .state(self.state))
        self.accountantObservers.notify(with: .money(moneyToNotify))
        self.money = Money(value: 0)
        print("\(self.name!) Finish task. Money sended: \(moneyToNotify.value)")
    }

    override func processInBackgroundThread() {
        print("\(self.name!) started a task")
        self.wash()
        self.collect()
        self.car = nil
    }
}
