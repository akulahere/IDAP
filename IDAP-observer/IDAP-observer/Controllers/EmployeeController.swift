//
//  EmployeeController.swift
//  IDAP-observer
//
//  Created by Dmytro Akulinin on 19.05.2023.
//

import Foundation

class EmployeeController<T> {
    
    // MARK: -
    // MARK: Variables

    let model: Employee<T>
    let view = EmployeeView()
    
    // MARK: -
    // MARK: Initializations and Deallocations

    init(employee: Employee<T>) {
        self.model = employee
    }
    
    // MARK: -
    // MARK: Public

    func processInMainThread(processable: T) {}
    
    func processInBackgroundThread(processable: T) {}
    
    final func startProcessing(processable: T) {
        self.model.state = .working
        DispatchQueue.global(qos: .background).async {
            self.processInBackgroundThread(processable: processable)
            self.model.state = .needsProcessing

            DispatchQueue.main.async {
                self.model.state = .ready
                self.processInMainThread(processable: processable)
            }
        }
    }
    
}
