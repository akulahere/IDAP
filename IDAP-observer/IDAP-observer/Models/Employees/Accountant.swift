//
//  Accountant.swift
//  IDAP-observer
//
//  Created by Dmytro Akulinin on 08.05.2023.
//

import Foundation

class Accountant: Employee<Money>, ObserverProtocol {

    // MARK: -
    // MARK: Vaiables
    
    var directorObservers = ThreadSafeObservers<Director>()

    // MARK: -
    // MARK: Public
    
    func add(observer: Director) {
        self.directorObservers.add(observer: observer)
    }
    
    
    func update(with notification: NotificationType) {
        print("Accountant start")
        guard case .money(let money) = notification else { return }
        startProcessing(processable: money)
    }

    // MARK: -
    // MARK: Private

    private func calculate(money: Money) {
        self.money.add(amount: money)
        print("Accountant calculate money: \(money.value)")
        sleep(UInt32(self.experience))
    }
    
    // MARK: -
    // MARK: Overrided
    
    override func processInBackgroundThread(processable: Money) {
        calculate(money: processable)
    }
    
    override func processInMainThread(processable: Money) {
        if self.money.value > 0 {
            print("Accountant Finish task: \(self.money.value)")
            self.directorObservers.notify(with: .money(self.money))
            self.money = Money(value: 0)
        }
    }
}
