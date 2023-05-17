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
    
//    var accountantObservers = ThreadSafeObservers<Accountant>()
//    var carWashObservers = ThreadSafeObservers<CarWash>()
    weak var washerDispatcher: Dispatcher<Car>?
    weak var accountantDispatcher: Dispatcher<Money>?
    // MARK: -
    // MARK: Public
    
//    func add(observer: Accountant) {
//        self.accountantObservers.add(observer: observer)
//    }
//    
//    func add(observer: CarWash) {
//        self.carWashObservers.add(observer: observer)
//    }
    
    
    // MARK: -
    // MARK: Private
    
    private func wash(car: Car) {
        sleep(UInt32(self.experience))
        car.isDirty = false
    }
    
    private func collect(car: Car) {
                let washPrice = 5.0  // - Test value
//        let washPrice = Double.random(in: 1...10).rounded()
        let payment = Money(value: washPrice)
        car.money.subtract(amount: payment)
        self.money.add(amount: payment)
    }
    
    // MARK: -
    // MARK: Overrided
    
    override func processInMainThread(processable: Car) {
        
        washerDispatcher?.update(with: .state(self.state))
        accountantDispatcher?.add(processable: self.money)

        print("\(self.name!) Finish task. Money sended: \(self.money.value)")
        
        self.money = Money(value: 0)
    }
    
    override func processInBackgroundThread(processable: Car) {
        print("\(self.name!) started a task")
        self.wash(car: processable)
        self.collect(car: processable)
    }
}
