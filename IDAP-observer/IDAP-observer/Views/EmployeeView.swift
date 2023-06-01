//
//  EmployeeView.swift
//  IDAP-observer
//
//  Created by Dmytro Akulinin on 19.05.2023.
//

import Foundation

class EmployeeView {
    
    // MARK: -
    // MARK: Public

    func printStartTask(name: String) {
        print("\(name) started a task")
    }
    
    func printFinishTask(name: String, money: Double) {
        print("\(name) Finish task. Money processed: \(money)")
    }
}
