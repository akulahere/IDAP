//
//  Human.swift
//  IDAP-OOP
//
//  Created by Dmytro Akulinin on 04.05.2023.
//

import Foundation

class Human {
    
    // MARK: -
    // MARK: typealias

    typealias Parents = (father: Human?, mother: Human?)
    
    // MARK: -
    // MARK: Variables
    
    private var ageValue: Age
    var age: Int {
        return self.ageValue.value
    }
    let gender: Gender
    let name: String

    // MARK: -
    // MARK: Initializations and Deallocations

    init(name: String, age: Int, gender: Gender) {
        self.name = name
        self.ageValue = Age(age: age)
        self.gender = gender
    }
    
    func increaseAge() {
        self.ageValue.increase()
    }
}
