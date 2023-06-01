//
//  AccountantController.swift
//  IDAP-observer
//
//  Created by Dmytro Akulinin on 19.05.2023.
//

import Foundation

class AccountantController: EmployeeController<Money> {
    
    // MARK: -
    // MARK: Variables

    var directorObservers = ThreadSafeObservers<DirectorController>()
    weak var accountanteDispatcher: Dispatcher<Money>?
    
    // MARK: -
    // MARK: Public

    func add(observer: DirectorController) {
        self.directorObservers.add(observer: observer)
    }
    
    // MARK: -
    // MARK: Private
    
    private func calculate(money: Money) {
        sleep(UInt32(self.model.experience))
        self.model.money.add(amount: money)
    }
    
    // MARK: -
    // MARK: Overrided
    
    override func processInBackgroundThread(processable: Money) {
        self.view.printStartTask(name: self.model.name)
        calculate(money: processable)
    }
    
    override func processInMainThread(processable: Money) {
        self.view.printFinishTask(name: self.model.name, money: self.model.money.value)
        
        self.accountanteDispatcher?.update(with: .state(self.model.state))
        self.directorObservers.notify(with: .money(self.model.money))
        
        self.model.money = Money(value: 0)
    }
}
