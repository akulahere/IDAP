//
//  ObserverProtocol.swift
//  IDAP-observer
//
//  Created by Dmytro Akulinin on 17.05.2023.
//

import Foundation

protocol ObserverProtocol: AnyObject {
    
    func update(with notification: NotificationType)
}

