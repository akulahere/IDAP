//
//  Dispatcher.swift
//  IDAP-observer
//
//  Created by Dmytro Akulinin on 16.05.2023.
//

import Foundation

class Dispatcher<T>: ObserverProtocol {
    // MARK: -
    // MARK: Variables
    
    private var queue: [T]
    private var handlers: [Employee<T>]
    private let dispatcherQueue = DispatchQueue(label: "com.carwash.dispatcher", attributes: .concurrent)

    // MARK: -
    // MARK: Initializations and Deallocations
    
    init(handlers: [Employee<T>]) {
        self.handlers = handlers
        self.queue = []
    }
    
    // MARK: -
    // MARK: Public
    
    func add(processable: T) {
        if let handler = self.handlers.first(where: { $0.state == .ready }) {
            handler.startProcessing(processable: processable)
        } else {
            self.queue.append(processable)
        }
    }
    
    // MARK: -
    // MARK: Observer protocol
    
    func update(with notification: NotificationType) {
        guard case .state(let state) = notification, state == .ready else { return }
        if let processable = self.queue.first {
            self.queue.removeFirst()
            self.add(processable: processable)
        }
    }
}
