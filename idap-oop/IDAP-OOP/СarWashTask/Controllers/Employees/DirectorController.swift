//
//  Director.swift
//  IDAP-OOP
//
//  Created by Dmytro Akulinin on 08.05.2023.
//

import Foundation

class DirectorController: MoneyTaker {
    
    // MARK: -
    // MARK: Variables
    
    private let view: DirectorView = DirectorView()
    private let model: Director

    // MARK: -
    // MARK: Initializations and Deallocations
    
    init(salary: Double, experience: Int) {
        let model = Director(salary: salary, experience: 3)
        self.model = model
    }
    
    // MARK: -
    // MARK: Private

    private func receive(money: Money) {
        self.model.money.add(amount: money)
        view.show(directorBalance: self.model.money.value)
    }

    // MARK: -
    // MARK: MoneyTaker

    func take(employee: MoneyContainable, payment: Money) {
        employee.give(money: payment)
        self.receive(money: payment)
    }
}
