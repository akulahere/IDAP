//
//  Money.swift
//  IDAP-observer
//
//  Created by Dmytro Akulinin on 08.05.2023.
//

import Foundation

class Money {
    
    // MARK: -
    // MARK: Vaiables

    private(set) var value: Double {
        willSet {
            if newValue < 0 {
                fatalError("Not enough money")
            }
        }
    }
    
    // MARK: -
    // MARK: Initializations and Deallocations

    init(value: Double) {
        self.value = value
    }
    
    // MARK: -
    // MARK: Public

    func subtract(amount: Money) {
        self.value -= amount.value
    }

    func add(amount: Money) {
        self.value += amount.value
    }
}

