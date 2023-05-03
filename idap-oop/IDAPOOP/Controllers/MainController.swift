//
//  MainController.swift
//  idap-oop
//
//  Created by Dmytro Akulinin on 03.05.2023.
//

import Foundation


struct MainController {
    
    // MARK: -
    // MARK: Public

    func run() {
        let danil = Human(name: "Danil", age: 15, gender: .male)
        let newMan = Person(name: "Ivan", age: 20, gender: .male, isMarried: false, parents: (nil, nil))

        let newWoman = Person(name: "Lera", age: 16, gender: .female, isMarried: false, parents: (nil, nil))
        let anotherMan = Person(name: "3", age: 3, gender: .female, isMarried: true, parents: (nil, nil), children: [danil])
        newMan.becomeMarried(partner: newWoman)
        print(anotherMan.age)
        print(anotherMan.childrenCount)
        anotherMan.makeChild(name: "33", gender: .female, with: newMan)
        print(anotherMan.childrenCount)
    }
}
