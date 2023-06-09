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
    
    var carWashController: CarWashController?
    
    // MARK: -
    // MARK: Initializations and Deallocations
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        let washer1 = Washer(salary: Money(value: 500), experience: 1)
        washer1.name = "Washer 1"
        let washer2 = Washer(salary: Money(value: 600), experience: 3)
        washer2.name = "Washer 2"
        let accountant = Accountant(salary: Money(value: 1000), experience: 4)
        accountant.name = "Accountant 1"
        let accountant2 = Accountant(salary: Money(value: 2000), experience: 1)
        accountant2.name = "Accountant 2"
        let director = Director(salary: Money(value: 2000), experience: 1)
        director.name = "Director"
        let carWash = CarWashController(washers: [washer1, washer2], accountants: [accountant, accountant2], director: director)
        self.carWashController = carWash
    }
    
    // MARK: -
    // MARK: Overrided
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.carWashController?.run()
    }
}
