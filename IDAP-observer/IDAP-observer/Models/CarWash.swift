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
    
    private var carQueue: [Car] = [] {
        didSet {
            print("Car added/removed from queue")
        }
    }
    
    let washers: [Washer]
    let accountant: Accountant
    let director: Director
    let carGenerator: CarGenerator = CarGenerator()

    let carWashQueue = DispatchQueue(label: "com.carwash.carwash", attributes: .concurrent)
    
    // MARK: -
    // MARK: Initializations and Deallocations
    
    init(washers: [Washer], accountant: Accountant, director: Director) {
        self.washers = washers
        self.accountant = accountant
        self.director = director
        self.carGenerator.carWash = self
        
        self.washers.forEach { washer in
            washer.add(observer: self)
            washer.add(observer: self.accountant)
        }
        
        self.accountant.add(observer: self.director)
        
    }
    
    // MARK: -
    // MARK: Public
    
    func addToQueue(car: Car) {
        carWashQueue.async(flags: .barrier) {
            self.carQueue.append(car)
            self.assignCar()
        }
    }
    
    func run() {
        self.carGenerator.startGeneratingCars()
    }
    
    // MARK: -
    // MARK: Private
    
    private func assignCar() {
        if let car = self.carQueue.first,
           let washer = self.washers.first(where: { $0.state == .ready }) {
            print("Car assign")
            self.carQueue.removeFirst()
            washer.startProcessing(processable: car)
        }
    }
    
    // MARK: -
    // MARK: Observer protocol
    
    func update(with notification: NotificationType) {
        guard case .state(_) = notification else { return }
        assignCar()
    }
}
