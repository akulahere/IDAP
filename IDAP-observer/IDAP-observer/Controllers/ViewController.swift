//
//  ViewController.swift
//  IDAP-observer
//
//  Created by Dmytro Akulinin on 08.05.2023.
//

import UIKit

class ViewController: UIViewController {
    var carWash: CarWash?
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        let washer1 = Washer(salary: Money(value: 500), experience: 2)
        washer1.name = "Washer 1"
        let washer2 = Washer(salary: Money(value: 600), experience: 3)
        washer2.name = "Washer 2"
        let accountant = Accountant(salary: Money(value: 1000), experience: 8)
        accountant.name = "Accountant"
        let director = Director(salary: Money(value: 2000), experience: 4)
        director.name = "Director"
        let carWash = CarWash(washers: [washer1, washer2], accountant: accountant, director: director)
        self.carWash = carWash
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        runCarWashTask()
    }
    
    func runCarWashTask() {
        let car = Car(isDirty: true, money: 100)
        var cars: [Car] = []
        
        for _ in 1...10  {
            let newCar = Car(isDirty: true, money: Double.random(in: 30...100).rounded())
            cars.append(newCar)
        }
//        print("Initial state: ")
//        print("Car is dirty: \(car.isDirty)")
//        print("Car money: \(car.money.value)")
//        print("Washer1 money: \(washer1.money.value)")
//        print("Accountant money: \(accountant.money.value)")
//        print("Director money: \(director.money.value)")
//        print("___________________________________________________")
        
        cars.forEach { car in
            self.carWash?.addToQueue(car: car)
            print("add one car")
        }
        
        
        

//        print("___________________________________________________")
//        print("Final state: ")
//        print("Car is dirty: \(car.isDirty)")
//        print("Car money: \(car.money.value)")
//        print("Washer1 money: \(washer1.money.value)")
////        print("Washer2 money: \(washer2.money.value)")
//        print("Accountant money: \(accountant.money.value)")
//        print("Director money: \(director.money.value)")
    }
}

