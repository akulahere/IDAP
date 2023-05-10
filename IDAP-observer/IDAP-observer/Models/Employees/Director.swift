//
//  Director.swift
//  IDAP-observer
//
//  Created by Dmytro Akulinin on 08.05.2023.
//

import Foundation

class Director: Employee, ObserverProtocol {
    func update(with notification: NotificationType) {
        print("Director start")
        guard case .money(let money) = notification else { return }
        self.money.add(amount: money)
        startProcessing()
    }
    
    // MARK: -
    // MARK: Public
    
//    func update(payment: Money) {
//        self.receive(money: payment)
//    }

    // MARK: -
    // MARK: Private

    private func receive() {
        sleep(UInt32(self.experience))
    }
    
    override func processInBackgroundThread() {
        receive()
    }
    
    override func processInMainThread() {
        print("Director finish collecting: \(self.money.value) ")
    }
}
