//
//  Money.swift
//  IDAP-observer
//
//  Created by Dmytro Akulinin on 08.05.2023.
//

import Foundation

class MoneyController {
    
    // MARK: -
    // MARK: Vaiables
    private var model: Money

    
    // MARK: -
    // MARK: Initializations and Deallocations

    init(value: Double) {
        self.model = Money(value: value)
    }
    
    // MARK: -
    // MARK: Public

    func subtract(amount: Money) {
        self.model.subtract(amount: amount)
    }

    func add(amount: Money) {
        self.model.add(amount: amount)
    }
}

