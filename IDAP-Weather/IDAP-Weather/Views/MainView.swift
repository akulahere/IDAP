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
    
    // MARK: -
    // MARK: Outlets

    @IBOutlet weak var tableView: UITableView?
    
    // MARK: -
    // MARK: Vairables

    weak var delegate: MainViewDelegate?
    
    // MARK: -
    // MARK: Public

    func setUpTable(delegate: MainViewDelegate) {
        self.tableView?.estimatedRowHeight = 120
        self.tableView?.rowHeight = UITableView.automaticDimension
        self.tableView?.delegate = delegate
        self.tableView?.dataSource = delegate
        self.tableView?.register(MainTableViewCell.self)
    }
    
}
