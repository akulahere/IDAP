//
//  DirectorController.swift
//  IDAP-observer
//
//  Created by Dmytro Akulinin on 19.05.2023.
//

import Foundation

class DirectorController: EmployeeController<Money>, ObserverProtocol {
    
    // MARK: -
    // MARK: Public

    func update(with notification: NotificationType) {
        guard case .money(let money) = notification else { return }
        self.startProcessing(processable: money)
    }
    
    // MARK: -
    // MARK: Private
    
    private func receive(money: Money) {
        sleep(UInt32(self.model.experience))
        self.model.money.add(amount: money)
    }
    
    // MARK: -
    // MARK: Overrided
    
    override func processInBackgroundThread(processable: Money) {
        print("Director start working")
        self.view.printStartTask(name: self.model.name)
        self.receive(money: processable)
    }
    
    override func processInMainThread(processable: Money) {
        self.view.printFinishTask(name: self.model.name, money: self.model.money.value)
    }
}
