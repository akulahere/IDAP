//
//  MainView.swift
//  IDAP-Square
//
//  Created by Dmytro Akulinin on 23.05.2023.
//

import UIKit

class MainView: UIView {
    
    // MARK: -
    // MARK: Variables

    var squarePosition: SquarePosition = .topLeft
    
    // MARK: -
    // MARK: Outlets

    @IBOutlet var square: UIButton?
    
    // MARK: -
    // MARK: Private

    private func setSquarePosition(_ position: SquarePosition) {
        setSquarePosition(position, animated: false)
    }
    
    private func setSquarePosition(_ position: SquarePosition, animated: Bool) {
        setSquarePosition(position, animated: animated, completionHandler: nil)
    }
    
    private func setSquarePosition(_ position: SquarePosition, animated: Bool, completionHandler: (() -> Void)?) {
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
            UIView.animate(withDuration: 3) {
                square.frame = newSquareFrame
            } completion: { _ in
                self.squarePosition = position
                completionHandler?()
            }
        } else {
            square.frame = newSquareFrame
            self.squarePosition = position
            completionHandler?()
        }
    }
    
    // MARK: -
    // MARK: Public

    func moveSquareToNextPositionInfinite() {
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
        
        setSquarePosition(nextPosition, animated: true) { [weak self] in
            self?.moveSquareToNextPositionInfinite()
        }
    }
}

