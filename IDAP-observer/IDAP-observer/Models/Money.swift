//
//  Money.swift
//  IDAP-observer
//
//  Created by Dmytro Akulinin on 08.05.2023.
//

import Foundation

 class Money {

     // MARK: -
     // MARK: Vaiables

     private(set) var value: Double {
         willSet {
             if newValue < 0 {
                 fatalError("Not enough money")
             }
         }
     }

     // MARK: -
     // MARK: Initializations and Deallocations

     init(value: Double) {
         self.value = value
     }

     // MARK: -
     // MARK: Public

     func subtract(amount: Money) {
         self.value -= amount.value
     }

     func add(amount: Money) {
         self.value += amount.value
     }
 }

/*
 //Trade safe implementation
 class Money {
     private let queue = DispatchQueue(label: "com.money.concurrent.queue", attributes: .concurrent)
     private var _value: Double
     
     var value: Double {
         get {
             return queue.sync { _value }
         }
         set {
             queue.async(flags: .barrier) {
                 if newValue < 0 {
                     fatalError("Not enough money")
                 }
                 self._value = newValue
             }
         }
     }
     
     init(value: Double) {
         self._value = value
     }

     func subtract(amount: Money) {
         queue.async(flags: .barrier) {
             self._value -= amount.value
         }
     }

     func add(amount: Money) {
         queue.async(flags: .barrier) {
             self._value += amount.value
         }
     }
 }
 */
