//
//  Accountant.swift
//  IDAP-observer
//
//  Created by Dmytro Akulinin on 08.05.2023.
//

import Foundation

class Accountant: Employee, ObserverProtocol {

    
    
    // MARK: -
    // MARK: Vaiables
    
    var directorObservers = ThreadSafeObservers<Director>()

    // MARK: -
    // MARK: Public
    
    func add(observer: Director) {
        self.directorObservers.add(observer: observer)
    }

    // MARK: -
    // MARK: Private

    private func calculate() {
        sleep(UInt32(self.experience))
    }
    
    func update(with notification: NotificationType) {
        print("Accountant start")
        guard case .money(let money) = notification else { return }
        self.money.add(amount: money)
        print("Accountant calculate money: \(money.value)")

        startProcessing()
    }
    
    override func processInBackgroundThread() {
        calculate()
    }
    
    override func processInMainThread() {
//        let moneyToNotify = self.money
//        self.directorObservers.notify(with: .money(moneyToNotify))
//        print("Accountant send money: \(moneyToNotify.value)")
//
//        self.money = Money(value: 0)
        if self.money.value > 0 {
            print("Accountant Finish task: \(self.money.value)")
            self.directorObservers.notify(with: .money(self.money))
            self.money = Money(value: 0)
        }
    }
}
