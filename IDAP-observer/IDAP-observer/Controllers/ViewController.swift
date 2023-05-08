//
//  ViewController.swift
//  IDAP-observer
//
//  Created by Dmytro Akulinin on 08.05.2023.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        runCarWashTask()
    }

    func runCarWashTask() {
        let washer1 = Washer(salary: Money(value: 500), experience: 2)
        let washer2 = Washer(salary: Money(value: 600), experience: 3)
        let accountant = Accountant(salary: Money(value: 1000), experience: 5)
        let director = Director(salary: Money(value: 2000), experience: 10)
        let carWash = CarWash(washers: [washer1, washer2], accountant: accountant, director: director)
        let car = Car(isDirty: true, money: 100)
        
        print("Initial state: ")
        print("Car is dirty: \(car.isDirty)")
        print("Car money: \(car.money.value)")
        print("Washer1 money: \(washer1.money.value)")
        print("Washer2 money: \(washer2.money.value)")
        print("Accountant money: \(accountant.money.value)")
        print("Director money: \(director.money.value)")
        print("___________________________________________________")
        
        carWash.wash(car: car)
        
        print("___________________________________________________")
        print("Final state: ")
        print("Car is dirty: \(car.isDirty)")
        print("Car money: \(car.money.value)")
        print("Washer1 money: \(washer1.money.value)")
        print("Washer2 money: \(washer2.money.value)")
        print("Accountant money: \(accountant.money.value)")
        print("Director money: \(director.money.value)")
    }
}

