//
//  Creature.swift
//  IDAP-OOP
//
//  Created by Dmytro Akulinin on 04.05.2023.
//

import Foundation


// Есть существо, у существа есть переменная пола, есть строка имени, есть масса, есть возраст, есть массив детей. Существо умеет воевать и рожать детей. При родах существо не добавляет к себе ребенка автоматом. Существо умеет добавит к себе детей и удалить. Существо умеет говорить "Привет!", причем, когда существо говорит привет, то сначала говорит оно, а потом все его дети (значит и дети детей, и т.д.).


class Creature: Equatable {
    
    
    
    // MARK: -
    // MARK: Variables
    private let id = UUID()
    let name: String
    let mass: Double
    var age: Int
    private(set) var children: [Creature] = []
    
    // MARK: -
    // MARK: Initializations and Deallocations
    
    init(name: String, mass: Double, age: Int) {
        self.name = name
        self.mass = mass
        self.age = age
    }
    
    
    
    // MARK: -
    // MARK: Public
    
    func add(child: Creature) {
        self.children.append(child)
    }
    
    func remove(child: Creature) {
        self.children.removeAll { $0 == child }
        
    }
    
    func sayHello() -> String {
        var greetings = "\(self.name) says: Hello!"
        for child in self.children {
            greetings += "\n\(child.sayHello())"
        }
        return greetings
    }
    
    // MARK: -
    // MARK: Equatable
    
    static func == (lhs: Creature, rhs: Creature) -> Bool {
        lhs.id == rhs.id
    }
}

class MaleCreature: Creature {
    func fight() -> String {
        return "\(self.name) fights!"
    }
    
    override func sayHello() -> String {
        var greetings = "\(self.name) says: Hello as Man!"
        for child in self.children {
            greetings += "\n\(child.sayHello())"
        }
        return greetings
    }
}

class FemaleCreature: Creature {
    func giveBirth(to name: String) -> Creature {
        let baby = Bool.random() ? MaleCreature(name: name, mass: 1.0, age: 0) :
                                   FemaleCreature(name: name, mass: 1.0, age: 0)
        return baby
    }
    
    override func sayHello() -> String {
        var greetings = "\(self.name) says: Hello as Woman!"
        for child in self.children {
            greetings += "\n\(child.sayHello())"
        }
        return greetings
    }
}
