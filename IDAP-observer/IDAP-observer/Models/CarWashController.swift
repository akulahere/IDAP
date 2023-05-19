//
//  CarWash.swift
//  IDAP-observer
//
//  Created by Dmytro Akulinin on 08.05.2023.
//

import Foundation

class CarWashController {
    
    // MARK: -
    // MARK: Variables
    
    let washerControllers: [WasherController]
    let accountantControllers: [AccountantController]
    let directorController: DirectorController

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

        self.washerControllers = washers.map({ washer in
            WasherController(employee: washer)
        })
        
        self.accountantControllers = accountants.map({ accountant in
            AccountantController(employee: accountant)
        })
        
        self.directorController = DirectorController(employee: director)

        self.washersDispatcher = Dispatcher(handlers: washerControllers)
        self.accountantDispatcher = Dispatcher(handlers: accountantControllers)

        
        self.washerControllers.forEach {
            $0.washerDispatcher = self.washersDispatcher
            $0.accountantDispatcher = self.accountantDispatcher
        }
        self.accountantControllers.forEach {
            $0.accountanteDispatcher = self.accountantDispatcher
            $0.directorObservers.add(observer: directorController)
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
