//
//  WasherView.swift
//  IDAP-OOP
//
//  Created by Dmytro Akulinin on 08.05.2023.
//

import Foundation

class WasherView {
    
    // MARK: -
    // MARK: Public

    func start() {
        print("___________________________________________________")
        print("Washer has started washing the car")
    }
    
    func show(amount: Double, washerBalance: Double, carBalance: Double) {
        print("___________________________________________________")
        print("Payment from collected. Ammount: \(amount)")
        print("Washer balance: \(washerBalance)")
        print("Car balance: \(carBalance)")
    }
}
