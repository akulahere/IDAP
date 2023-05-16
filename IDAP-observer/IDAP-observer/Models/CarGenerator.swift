//
//  CarGenerator.swift
//  IDAP-observer
//
//  Created by Dmytro Akulinin on 16.05.2023.
//

import Foundation

class CarGenerator {
    
    // MARK: -
    // MARK: Variables
    
    private let carGeneratorQueue = DispatchQueue(label: "com.carwash.cargenerator", attributes: .concurrent)
    
    weak var carWash: CarWash?
    
    // MARK: -
    // MARK: Public
    
    func startGeneratingCars() {
        for _ in 1...4 {
            self.carGeneratorQueue.async { [weak self] in
                let newCar = Car(isDirty: true, money: Double.random(in: 30...100).rounded())
                print("Car created")
                self?.carWash?.addToQueue(car: newCar)
            }
        }
    }
}
