//
//  Coordinator.swift
//  IDAP-Weather
//
//  Created by Dmytro Akulinin on 12.06.2023.
//

import UIKit

protocol Coordinator {
    var navigationController: UINavigationController { get set }
    func start()
}
