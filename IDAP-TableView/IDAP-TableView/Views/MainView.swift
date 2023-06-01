//
//  MainView.swift
//  IDAP-TableView
//
//  Created by Dmytro Akulinin on 31.05.2023.
//

import UIKit

protocol MainViewDelegate: MainViewController {
    func addNewCell()
    func sortCells()
    func toggleEditing()
}

class MainView: UIView {
    @IBOutlet weak var tableView: UITableView?
    weak var delegate: MainViewDelegate?

    func setUpNavBar(delegate: MainViewDelegate) {
        let addButton = UIBarButtonItem(barButtonSystemItem: .add, target: delegate, action: #selector(delegate.addNewCell))
        let sortButton = UIBarButtonItem(title: "Sort", style: .plain, target: delegate, action: #selector(delegate.sortCells))
        let editButton = UIBarButtonItem(barButtonSystemItem: .edit, target: delegate, action: #selector(delegate.toggleEditing))
        delegate.navigationItem.rightBarButtonItems = [addButton, sortButton]
        delegate.navigationItem.leftBarButtonItem = editButton
    }

    func setUpTable(delegate: MainViewDelegate) {
        self.tableView?.delegate = delegate
        self.tableView?.dataSource = delegate
        self.tableView?.register(CustomTableViewCell.self)
    }

    func reloadTable() {
        guard let tableView = self.tableView else { return }

        UIView.transition(with: tableView, duration: 1.0, options: .transitionCrossDissolve, animations: { tableView.reloadData() }, completion: nil)
    }
}
