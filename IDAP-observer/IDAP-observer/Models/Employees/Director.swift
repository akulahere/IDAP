//
//  Director.swift
//  IDAP-observer
//
//  Created by Dmytro Akulinin on 08.05.2023.
//

import Foundation

class Director: Employee<Money>, ObserverProtocol {
    
    // MARK: -
    // MARK: Public
    
    func update(with notification: NotificationType) {
        print("Director start")
        guard case .money(let money) = notification else { return }
        startProcessing(processable: money)
    }
    
    // MARK: -
    // MARK: Private
    
    private func receive(money: Money) {
        self.money.add(amount: money)
        sleep(UInt32(self.experience))
    }
    
    // MARK: -
    // MARK: Overrided
    
    override func processInBackgroundThread(processable: Money) {
        receive(money: processable)
    }
    
    override func processInMainThread(processable: Money) {
        print("Director finish collecting: \(self.money.value) ")
    }
}
