//
//  ViewController.swift
//  IDAP-observer
//
//  Created by Dmytro Akulinin on 08.05.2023.
//

import UIKit

class ViewController: UIViewController {
    
    // MARK: -
    // MARK: Variables
    
    var carWash: CarWash?
    
    // MARK: -
    // MARK: Initializations and Deallocations
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        let washer1 = Washer(salary: Money(value: 500), experience: 1)
        washer1.name = "Washer 1"
        let washer2 = Washer(salary: Money(value: 600), experience: 3)
        washer2.name = "Washer 2"
        let accountant = Accountant(salary: Money(value: 1000), experience: 4)
        accountant.name = "Accountant"
        let director = Director(salary: Money(value: 2000), experience: 1)
        director.name = "Director"
        let carWash = CarWash(washers: [washer1, washer2], accountant: accountant, director: director)
        self.carWash = carWash
    }
    
    // MARK: -
    // MARK: Overrided
    
    override func viewDidLoad() {
        super.viewDidLoad()
        carWash?.run()
    }
}
