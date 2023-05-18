//
//  Accountant.swift
//  IDAP-observer
//
//  Created by Dmytro Akulinin on 08.05.2023.
//

import Foundation

class Accountant: Employee<Money> {

    // MARK: -
    // MARK: Vaiables
    
    var directorObservers = ThreadSafeObservers<Director>()
    weak var accountanteDispatcher: Dispatcher<Money>?
    
    // MARK: -
    // MARK: Public
    
    func add(observer: Director) {
        self.directorObservers.add(observer: observer)
    }

    // MARK: -
    // MARK: Private

    private func calculate(money: Money) {
        sleep(UInt32(self.experience))
        self.money.add(amount: money)
        print("\(self.name!) calculate money: \(money.value)")
    }
    
    // MARK: -
    // MARK: Overrided
    
    override func processInBackgroundThread(processable: Money) {
        calculate(money: processable)
    }
    
    override func processInMainThread(processable: Money) {
        if self.money.value > 0 {
            print("Accountant Finish task: \(self.money.value)")
            self.accountanteDispatcher?.update(with: .state(self.state))
            self.directorObservers.notify(with: .money(self.money))
            self.money = Money(value: 0)
        }
    }
}
