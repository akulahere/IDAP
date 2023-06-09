//
//  MainView.swift
//  IDAP-Weather
//
//  Created by Dmytro Akulinin on 01.06.2023.
//

import UIKit

protocol MainViewDelegate: MainViewController {
    var currentCity: String { get }
}

class MainView: UIView {
    
    // MARK: -
    // MARK: Outlets

    @IBOutlet weak var tableView: UITableView?
    @IBOutlet weak var currentCity: UILabel?
    
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
    
    func setUpCityLabel(text: String?) {
        let labelText = text ?? "Unknown city"
        self.currentCity?.text = "Current city: \(labelText)"
    }
    
}
