//
//  ViewController.swift
//  IDAP-Square
//
//  Created by Dmytro Akulinin on 23.05.2023.
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

class MainViewController: UIViewController, RootViewGettable {
    
    typealias RootViewType = MainView

    // MARK: -
    // MARK: Variables

    var squarePosition: SquarePosition = .topLeft
    
    // MARK: -
    // MARK: IBActions

    @IBAction func handleSquareTap() {
        moveSquareToNextPositionInfinite()
    }
    
    // MARK: -
    // MARK: Overrided

    override func viewDidLoad() {
        super.viewDidLoad()
        rootView?.backgroundColor = .blue
        rootView?.setSquare(position: squarePosition, animated: false)
    }
    
    // MARK: -
    // MARK: Private

    private func moveSquareToNextPositionInfinite() {
        var nextPosition: SquarePosition
        
        switch squarePosition {
            case .topLeft:
                nextPosition = .topRight
            case .topRight:
                nextPosition = .bottomRight
            case .bottomRight:
                nextPosition = .bottomLeft
            case .bottomLeft:
                nextPosition = .topLeft
        }
        
        rootView?.setSquare(position: nextPosition, animated: true) { [weak self] in
            self?.squarePosition = nextPosition
            self?.moveSquareToNextPositionInfinite()
        }
    }
}
