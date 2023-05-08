//
//  Age.swift
//  IDAP-OOP
//
//  Created by Dmytro Akulinin on 04.05.2023.
//

import Foundation

struct Age {
    private(set) var value: Int
    
    init(age: Int) {
        self.value = age
    }
    
    mutating func increase() {
        self.value += 1
    }
}
