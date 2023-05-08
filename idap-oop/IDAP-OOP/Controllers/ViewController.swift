//
//  ViewController.swift
//  IDAP-OOP
//
//  Created by Dmytro Akulinin on 04.05.2023.
//

import UIKit

class ViewController: UIViewController {
    
    // MARK: -
    // MARK: View Life Cycle

    override func viewDidLoad() {
        super.viewDidLoad()
        print("Test")
        runCarWashTask()
    }
    
    func runHumanTask() {
        let danil = Human(name: "Danil", age: 15, gender: .male)
        let newMan = Person(name: "Ivan", age: 20, gender: .male, isMarried: false, parents: (nil, nil))
        let newWoman = Person(name: "Lera", age: 16, gender: .female, isMarried: false, parents: (nil, nil))
        let anotherMan = Person(name: "3", age: 3, gender: .female, isMarried: true, parents: (nil, nil), children: [danil])
        newMan.increaseAge()
        newMan.becomeMarried(partner: newWoman)
        anotherMan.makeChild(name: "33", gender: .female, with: newMan)

        print(anotherMan.age)
        print(newMan.age)
        print(anotherMan.childrenCount)
        print(anotherMan.childrenCount)
    }
    
    func runCreatureTask() {
        let ancientCreautre = Creature(name: "Ancient1", mass: 900, age: 100)
        
        let femaleCreature = FemaleCreature(name: "female1", mass: 100, age: 10)
        let femaleCreature1 = FemaleCreature(name: "female2", mass: 100, age: 10)
        
        let child1 = femaleCreature.giveBirth(to: "Manual child 1")
        let child2 = femaleCreature.giveBirth(to: "Manual child 2")
        let child3 = femaleCreature1.giveBirth(to: "Manual child 3")
        
        var zoo = [ancientCreautre, femaleCreature, child1, child2, child3]
        zoo.forEach { creature in
            if let female = creature as? FemaleCreature {
                zoo.append(female.giveBirth(to: "Random child \(Int.random(in: 1...100))"))
            }
        }
        zoo.forEach { print($0.sayHello()) }
    }
    
    func runCarWashTask() {
        let carWash = CarWashController()
        let car = Car(isDirty: true, money: 100)
        
        print("Initial state: ")
        print("Car is dirty: \(car.isDirty)")
        print("Car money: \(car.money.value)")
//        print("Washer1 money: \(washer1.money.value)")
//        print("Washer2 money: \(washer2.money.value)")
//        print("Accountant money: \(accountant.money.value)")
//        print("Director money: \(director.money.value)")
//        print("___________________________________________________")
        
        carWash.wash(car: car)
        
        print("___________________________________________________")
        print("Final state: ")
        print("Car is dirty: \(car.isDirty)")
        print("Car money: \(car.money.value)")
//        print("Washer1 money: \(washer1.money.value)")
//        print("Washer2 money: \(washer2.money.value)")
//        print("Accountant money: \(accountant.money.value)")
//        print("Director money: \(director.money.value)")
    }
}
