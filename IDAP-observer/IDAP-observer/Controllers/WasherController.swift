//
//  WasherController.swift
//  IDAP-observer
//
//  Created by Dmytro Akulinin on 19.05.2023.
//

import Foundation

class WasherController: EmployeeController<Car> {
    
    // MARK: -
    // MARK: Vaiables

    weak var washerDispatcher: Dispatcher<Car>?
    weak var accountantDispatcher: Dispatcher<Money>?
    
    // MARK: -
    // MARK: Private

    private func wash(car: Car) {

        sleep(UInt32(self.model.experience))
        car.isDirty = false
    }

    private func collect(car: Car) {

        let washPrice = Double.random(in: 1...10).rounded()
        let payment = Money(value: washPrice)
        car.money.subtract(amount: payment)
        self.model.money.add(amount: payment)
    }
    
    // MARK: -
    // MARK: Overrided

    override func processInMainThread(processable: Car) {
        
        self.accountantDispatcher?.add(processable: self.model.money)
        self.washerDispatcher?.update(with: .state(self.model.state))

        self.view.printFinishTask(name: self.model.name, money: self.model.money.value)
        
        self.model.money = Money(value: 0)
    }
    
    override func processInBackgroundThread(processable: Car) {
        
        self.view.printStartTask(name: self.model.name)
        
        self.wash(car: processable)
        self.collect(car: processable)
    }
}
