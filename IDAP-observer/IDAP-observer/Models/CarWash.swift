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
    let carGeneratorQueue = DispatchQueue(label: "com.carwash.cargenerator", attributes: .concurrent)
    
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
    
    func startGeneratingCars() {
        carGeneratorQueue.async { [weak self] in
            for _ in 1...100 {
                let newCar = Car(isDirty: true, money: Double.random(in: 30...100).rounded())
                self?.addToQueue(car: newCar)
                print("A new car was generated and added to the queue.")
            }
        }
    }
    
    // MARK: -
    // MARK: Private
    
    private func assignCar() {
        if let car = self.carQueue.first,
           let washer = self.washers.first(where: { $0.state == .ready }) {
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
