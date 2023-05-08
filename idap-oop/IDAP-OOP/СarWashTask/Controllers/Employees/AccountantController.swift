//
//  Accountant.swift
//  IDAP-OOP
//
//  Created by Dmytro Akulinin on 08.05.2023.
//

import Foundation

class AccountantController: MoneyTaker, MoneyContainable
{
    
    // MARK: -
    // MARK: Vaiables

    weak var delegate: MoneyTaker?
    private let model: Accountant
    private let view: AccountantView = AccountantView()
    
    // MARK: -
    // MARK: Initializations and Deallocations

    init(salary: Double, experience: Int) {
        let model = Accountant(salary: salary, experience: 3)
        self.model = model
    }
    
    // MARK: -
    // MARK: Private

    private func calculate(payment: Money) {
        self.model.money.add(amount: payment)
        self.delegate?.take(employee: self, payment: payment)
        
        self.view.show(accountantBalance: self.model.money.value)
    }

    // MARK: -
    // MARK: MoneyTaker
    
    func take(employee: MoneyContainable, payment: Money) {
        employee.give(money: payment)
        self.calculate(payment: payment)
    }
    
    // MARK: -
    // MARK: MoneyContainable

    func give(money: Money) {
        self.model.money.subtract(amount: money)
    }
}
