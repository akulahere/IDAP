//
//  BaseTableViewCell.swift
//  IDAP-TableView
//
//  Created by Dmytro Akulinin on 26.05.2023.
//

import UIKit

class BaseTableViewCell: UITableViewCell {
    
    // MARK: -
    // MARK: Variables

    static var nib: UINib {
        return UINib(nibName: String(describing: self), bundle: nil)
    }

    static var reuseIdentifier: String {
        return String(describing: self)
    }

    // MARK: -
    // MARK: Public

    class func loadFromNib() -> Self {
        return loadFromNibHelper()
    }
    
    class func loadFromNibHelper<T>() -> T {
        return UINib(nibName: String(describing: self), bundle: nil).instantiate(withOwner: nil, options: nil).first as! T
    }
}
