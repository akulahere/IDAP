//
//  CarWash.swift
//  IDAP-observer
//
//  Created by Dmytro Akulinin on 08.05.2023.
//

import Foundation

class CarWash: ObserverProtocol {
    
    // MARK: -
    // MARK: Variables
    
    private var carQueue: [Car] = []
    
    let washers: [Washer]
    let accountant: Accountant
    let director: Director
    
    // MARK: -
    // MARK: Initializations and Deallocations
    
    init(washers: [Washer], accountant: Accountant, director: Director) {
        self.washers = washers
        self.accountant = accountant
        self.director = director
        
        self.washers.forEach { washer in
            washer.add(observer: self)
            washer.add(observer: self.accountant)
        }
        self.accountant.add(observer: self.director)
    }
    
    // MARK: -
    // MARK: Public
    
    func addToQueue(car: Car) {
        self.carQueue.append(car)
        self.assignCar()
    }
    
    // MARK: -
    // MARK: Private

    private func assignCar() {
        if let car = self.carQueue.first,
           let washer = self.washers.first(where: { $0.state == .ready }) {
            washer.car = car
            self.carQueue.removeFirst()
            washer.startProcessing()
        }
    }
    
    // MARK: -
    // MARK: Observer protocol

    func update(with notification: NotificationType) {
        guard case .state(_) = notification else { return }
        assignCar()
    }
}
