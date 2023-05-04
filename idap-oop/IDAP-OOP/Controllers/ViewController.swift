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
        
        print("Creature")
        let creature = Creature(name: "Creature1", gender: .male, mass: 80, age: 30)
        let child1 = creature.giveBirth(to: "Baby1")
        creature.addChild(child1)

        let grandChild1 = child1.giveBirth(to: "Baby1-GrandBaby-1")
        child1.addChild(grandChild1)

        let child2 = creature.giveBirth(to: "Baby2")
        creature.addChild(child2)

        let grandChild2 = child2.giveBirth(to: "Baby2-GrandBaby1")
        child2.addChild(grandChild2)

        let grandChild3 = child2.giveBirth(to: "Baby2-GrandBaby2")
        child2.addChild(grandChild3)

        print(creature.sayHello())
        
        print("------REMOVE-----")
        creature.removeChild(child1)
        print(creature.sayHello())
    }
}
