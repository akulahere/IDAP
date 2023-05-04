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
    }
}
