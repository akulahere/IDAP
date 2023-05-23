//
//  ViewController.swift
//  IDAP-Square
//
//  Created by Dmytro Akulinin on 23.05.2023.
//

import UIKit

class ViewController: UIViewController {

    // MARK: -
    // MARK: Outlets

    @IBOutlet var mainView: MainView!
    
    // MARK: -
    // MARK: IBActions

    @IBAction func handleSquareTap() {
        mainView.moveSquareToNextPositionInfinite()

    }
    
    // MARK: -
    // MARK: Overrided

    override func viewDidLoad() {
        super.viewDidLoad()
        mainView.backgroundColor = .blue
    }
}
