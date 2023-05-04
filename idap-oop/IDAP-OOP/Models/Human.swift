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
    
    // I've tried to make propertyWrapper but I don't understand how to use to ride off
    // increaseAge method
//    @propertyWrapper struct Age {
//        private(set) var wrappedValue: Int
//
//        init(wrappedValue: Int) {
//            self.wrappedValue = max(0, wrappedValue)
//        }
//
//        mutating func increase() {
//            wrappedValue += 1
//        }
//    }
    
//    @Age var age: Int
    private(set) var age: Int
    let gender: Gender
    let name: String

    // MARK: -
    // MARK: Initializations and Deallocations

    init(name: String, age: Int, gender: Gender) {
        self.name = name
        self.age = age
        self.gender = gender
    }
    
    func increaseAge() {
        age += 1
    }
}
