//
//  CarWash.swift
//  IDAP-observer
//
//  Created by Dmytro Akulinin on 08.05.2023.
//

import Foundation

class CarWash {
    
    // MARK: -
    // MARK: Variables
    
    private var carQueue: [Car] = [] {
        didSet {
            print("Car added/removed from queue")
        }
    }
    
    let washers: [Washer]
    let accountants: [Accountant]
    let director: Director

    lazy private(set) var carGenerator: CarGenerator = {
        return CarGenerator(carHandler: { [weak self] car in
            self?.addToQueue(car: car)
        })
    }()
    
    let washersDispatcher: Dispatcher<Car>
    let accountantDispatcher: Dispatcher<Money>
    
    let carWashQueue = DispatchQueue(label: "com.carwash.carwash", attributes: .concurrent)
    
    // MARK: -
    // MARK: Initializations and Deallocations
    
    init(washers: [Washer], accountants: [Accountant], director: Director) {
        self.washers = washers
        self.accountants = accountants
        
        self.washersDispatcher = Dispatcher(handlers: washers)
        self.accountantDispatcher = Dispatcher(handlers: accountants)
        
        self.director = director

        
        self.washers.forEach {
            $0.washerDispatcher = self.washersDispatcher
            $0.accountantDispatcher = self.accountantDispatcher
        }
        self.accountants.forEach {
            $0.accountanteDispatcher = self.accountantDispatcher
            $0.directorObservers.add(observer: director)
        }

    }
    
    // MARK: -
    // MARK: Public
    
    func addToQueue(car: Car) {
        carWashQueue.async(flags: .barrier) {
            self.washersDispatcher.add(processable: car)
        }
    }
    
    func run() {
        self.carGenerator.startGeneratingCars()
    }
}
