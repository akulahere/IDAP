//
//  Creature.swift
//  IDAP-OOP
//
//  Created by Dmytro Akulinin on 04.05.2023.
//

import Foundation


// Есть существо, у существа есть переменная пола, есть строка имени, есть масса, есть возраст, есть массив детей. Существо умеет воевать и рожать детей. При родах существо не добавляет к себе ребенка автоматом. Существо умеет добавит к себе детей и удалить. Существо умеет говорить "Привет!", причем, когда существо говорит привет, то сначала говорит оно, а потом все его дети (значит и дети детей, и т.д.).


class Creature {
    
    // MARK: -
    // MARK: Variables
    
    let name: String
    let gender: Gender
    let mass: Double
    var age: Int
    private(set) var children: [Creature] = []

    // MARK: -
    // MARK: Initializations and Deallocations
    
    init(name: String, gender: Gender, mass: Double, age: Int) {
        self.name = name
        self.gender = gender
        self.mass = mass
        self.age = age
    }

    
    func fight() -> String {
        return "\(name) fights!"
    }

    // MARK: -
    // MARK: Public
    
    func giveBirth(to name: String) -> Creature {
        let babyGender = Bool.random() ? Gender.male : Gender.female
        return Creature(name: name, gender: babyGender, mass: 1.0, age: 0)
    }

    func addChild(_ child: Creature) {
        self.children.append(child)
    }

    func removeChild(_ child: Creature) {
        if let index = self.children.firstIndex(where: { $0.name == child.name }) {
            self.children.remove(at: index)
        }
    }

    func sayHello() -> String {
        var greetings = "\(self.name) says: Hello!"
        for child in self.children {
            greetings += "\n\(child.sayHello())"
        }
        return greetings
    }
}

