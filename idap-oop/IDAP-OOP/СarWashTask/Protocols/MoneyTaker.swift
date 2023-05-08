//
//  MoneyTaker.swift
//  IDAP-OOP
//
//  Created by Dmytro Akulinin on 08.05.2023.
//

import Foundation

protocol MoneyTaker: AnyObject {
    
    func take(employee: MoneyContainable, payment: Money)
}
