//
//  ViewController.swift
//  IDAP-TableView
//
//  Created by Dmytro Akulinin on 26.05.2023.
//

import UIKit

class MainViewController: UIViewController, RootViewGettable {
    typealias RootViewType = UIView
    

    override func viewDidLoad() {
        super.viewDidLoad()
        rootView?.backgroundColor = .blue
    }


}

