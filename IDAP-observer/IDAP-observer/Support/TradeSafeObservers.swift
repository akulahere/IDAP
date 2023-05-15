//
//  TradeSafeObservers.swift
//  IDAP-observer
//
//  Created by Dmytro Akulinin on 10.05.2023.
//

import Foundation

class ThreadSafeObservers<T: ObserverProtocol> {
    
    // MARK: -
    // MARK: Variables
    
    private var observers: [Weak<T>]
//    private var observers: [T]
    private let queue = DispatchQueue(label: "com.carwash.observers", attributes: .concurrent)
    
    // MARK: -
    // MARK: Initializations and Deallocations
    
    init() {
        self.observers = []
    }
    
    // MARK: -
    // MARK: Public
    
    func add(observer: T) {
        queue.async(flags: .barrier) {
//            self.observers.append(observer)
            self.observers.append(Weak(value: observer))
        }
    }
    
    func notify(with notification: NotificationType) {
        queue.sync {
            for observer in self.observers {
                DispatchQueue.main.async {
                    if let observer = observer.value {
                        observer.update(with: notification)
                    }
                }
            }
        }
    }
}

enum NotificationType {
    
    case money(Money)
    case state(WorkerState)
}

protocol ObserverProtocol: AnyObject {
    
    func update(with notification: NotificationType)
}
