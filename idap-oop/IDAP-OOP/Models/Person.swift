//
//  Person.swift
//  IDAP-OOP
//
//  Created by Dmytro Akulinin on 04.05.2023.
//

import Foundation

class Person: Human {
    
    // MARK: -
    // MARK: Variables
    
    private(set) var isMarried: Bool
    private(set) var partner: Person?
    private(set) var parents: Parents
    
    var childrenCount: Int {
        return children.count
    }
    
    private(set) var children: [Human] {
        willSet {
            if children.count >= 20 {
                fatalError("A person can have at most 20 children.")
            }
        }
    }
    
    // MARK: -
    // MARK: Initializations and Deallocations

    init(name: String,
         age: Int,
         gender: Gender,
         isMarried: Bool,
         partner: Person? = nil,
         parents: Parents,
         children: [Human] = [])
    {
        self.isMarried = isMarried
        self.partner = partner
        self.parents = parents
        self.children = children
        
        if children.count > 20 {
            fatalError("A person can have at most 20 children.")
        }
        super.init(name: name, age: age, gender: gender)
    }
    
    // MARK: -
    // MARK: Public

    func becomeMarried(partner: Person) {
        self.isMarried = true
        partner.isMarried = true
        partner.partner = partner
        self.partner = partner
    }
    
    func becomeDivorced() {
        self.isMarried = false
        partner?.isMarried = false
        partner?.partner = nil
        self.partner = nil
    }
    
    func makeChild(name: String, gender: Gender, with partner: Person) {
        let parents: Parents = self.gender == .male ? (self, partner) : (partner, self)
        let child = Child(name: name, age: 0, gender: gender, parents: parents)
        if self.children.count < 20 && partner.children.count < 20 {
            self.children.append(child)
            partner.children.append(child)
        } else {
            fatalError("A person can have at most 20 children.")
        }
    }
}
