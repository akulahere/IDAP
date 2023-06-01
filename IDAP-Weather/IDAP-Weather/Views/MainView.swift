//
//  MainView.swift
//  IDAP-Weather
//
//  Created by Dmytro Akulinin on 01.06.2023.
//

import UIKit
protocol MainViewDelegate: MainViewController {
    
}
class MainView: UIView {
    @IBOutlet weak var tableView: UITableView?
    weak var delegate: MainViewDelegate?
    
    func setUpTable(delegate: MainViewDelegate) {
        self.tableView?.delegate = delegate
        self.tableView?.dataSource = delegate
//        self.tableView?.register(CustomTableViewCell.self)
    }
    
}
