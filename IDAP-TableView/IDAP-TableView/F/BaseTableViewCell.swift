//
//  BaseTableViewCell.swift
//  IDAP-TableView
//
//  Created by Dmytro Akulinin on 26.05.2023.
//

import UIKit

//class BaseTableViewCell: UITableViewCell {
//
//    // MARK: -
//    // MARK: Variables
//
////    static var nib: UINib {
////        return UINib(nibName: String(describing: self), bundle: nil)
////    }
////
////    static var reuseIdentifier: String {
////        return String(describing: self)
////    }
//
//    // MARK: -
//    // MARK: Public
//
//    class func loadFromNib() -> Self {
//        return loadFromNibHelper()
//    }
//
//    class func loadFromNibHelper<T>() -> T {
//        return UINib(nibName: String(describing: self), bundle: nil).instantiate(withOwner: nil, options: nil).first as! T
//    }
//}
//
//
//extension UITableViewCell {
//    static var nib: UINib {
//        return UINib(nibName: String(describing: self), bundle: nil)
//    }
//
//    static var reuseIdentifier: String {
//        return String(describing: self)
//    }
//}

//protocol Reusable {
//    associatedtype CellType : UITableViewCell = Self
//
//    static var cellIdentifier : String { get }
//    static func dequeueReusableCell(in tableView : UITableView, for indexPath: IndexPath) -> CellType
//}
//
//extension Reusable where Self : UITableViewCell {
//
//    static var cellIdentifier : String {
//        return String(describing: Self.self)
//    }
//
//    static func dequeueReusableCell(in tableView : UITableView, for indexPath: IndexPath) -> CellType {
//        return tableView.dequeueReusableCell(withIdentifier: cellIdentifier, for: indexPath) as! CellType
//    }
//}
