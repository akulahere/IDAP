//
//  Child.swift
//  idap-oop
//
//  Created by Dmytro Akulinin on 03.05.2023.
//

import Foundation

class Child: Human {
    
    // MARK: -
    // MARK: Variables

    private(set) var parents: Parents
    
    // MARK: -
    // MARK: Initializations and Deallocations

    init(name: String, age: Int = 0, gender: Gender, parents: Parents) {
        self.parents = parents
        super.init(name: name, age: age, gender: gender)
    }
}
