//
//  MainView.swift
//  IDAP-Square
//
//  Created by Dmytro Akulinin on 23.05.2023.
//

import UIKit

class MainView: UIView {
    
    // MARK: -
    // MARK: Outlets

    @IBOutlet var square: UIButton?

    // MARK: -
    // MARK: Public

    func setSquare(position: SquarePosition) {
        self.setSquare(position: position, animated: false)
    }
    
    func setSquare(position: SquarePosition, animated: Bool) {
        self.setSquare(position: position, animated: animated, completionHandler: nil)
    }
    
    func setSquare(position: SquarePosition, animated: Bool, completionHandler: (() -> Void)?) {
        
        guard let square = self.square else { return }
        
        let squareSideSize = square.frame.width
        let newSquareFrame: CGRect
        
        switch position {
            case .topLeft:
                newSquareFrame = CGRect(x: 0, y: 0, width: squareSideSize, height: squareSideSize)
            case .topRight:
                newSquareFrame = CGRect(x: self.bounds.width - squareSideSize, y: 0, width: squareSideSize, height: squareSideSize)
            case .bottomLeft:
                newSquareFrame = CGRect(x: 0, y: self.bounds.height - squareSideSize, width: square.frame.width, height: squareSideSize)
            case .bottomRight:
                newSquareFrame = CGRect(x: self.bounds.width - squareSideSize, y: self.bounds.height - squareSideSize, width: squareSideSize, height: squareSideSize)
        }
        
        if animated {
            UIView.animate(withDuration: 3, animations: {
                square.frame = newSquareFrame
            }, completion: { _ in
                completionHandler?()
            })
        } else {
            square.frame = newSquareFrame
            completionHandler?()
        }
    }
}

