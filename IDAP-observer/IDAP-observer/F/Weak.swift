//
//  Weak.swift
//  IDAP-observer
//
//  Created by Dmytro Akulinin on 09.05.2023.
//

import Foundation

class Weak<T: AnyObject> {
    
    // MARK: -
    // MARK: Variables
    
    weak var value : T?
    
    // MARK: -
    // MARK: Initializations and Deallocations
    
    init (value: T) {
        self.value = value
    }
}
