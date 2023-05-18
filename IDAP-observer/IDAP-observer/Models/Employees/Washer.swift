//
//  Washer.swift
//  IDAP-observer
//
//  Created by Dmytro Akulinin on 08.05.2023.
//

import Foundation


class Washer: Employee<Car> {
    
    // MARK: -
    // MARK: Variables
    
    weak var washerDispatcher: Dispatcher<Car>?
    weak var accountantDispatcher: Dispatcher<Money>?
    
    // MARK: -
    // MARK: Private
    
    private func wash(car: Car) {
        sleep(UInt32(self.experience))
        car.isDirty = false
    }
    
    private func collect(car: Car) {
        let washPrice = Double.random(in: 1...10).rounded()
        let payment = Money(value: washPrice)
        car.money.subtract(amount: payment)
        self.money.add(amount: payment)
    }
    
    // MARK: -
    // MARK: Overrided
    
    override func processInMainThread(processable: Car) {
        
        self.accountantDispatcher?.add(processable: self.money)
        self.washerDispatcher?.update(with: .state(self.state))

        print("\(self.name!) Finish task. Money sended: \(self.money.value)")
        
        self.money = Money(value: 0)
    }
    
    override func processInBackgroundThread(processable: Car) {
        print("\(self.name!) started a task")
        self.wash(car: processable)
        self.collect(car: processable)
    }
}
