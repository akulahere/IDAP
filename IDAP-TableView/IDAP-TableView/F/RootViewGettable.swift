//
//  RootViewGettable.swift
//  IDAP-TableView
//
//  Created by Dmytro Akulinin on 26.05.2023.
//

import UIKit

protocol RootViewGettable {

    associatedtype RootViewType: UIView
    
    var rootView: RootViewType? { get }
}

extension RootViewGettable where Self: UIViewController {
    var rootView: RootViewType? {
        self.view as? RootViewType
    }
}
