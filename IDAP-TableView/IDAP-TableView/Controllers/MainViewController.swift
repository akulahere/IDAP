//
//  ViewController.swift
//  IDAP-TableView
//
//  Created by Dmytro Akulinin on 26.05.2023.
//

import UIKit

class MainViewController: UIViewController {

    // MARK: -
    // MARK: Variables

    var tableView: UITableView?
    var arrayModel: ArrayModel
    var image: UIImage?
    
    // MARK: -
    // MARK: Initialization and Dealocationn
    
    init(model: ArrayModel) {
        if let pepeImage = UIImage(named: "pepe") {
            self.image = pepeImage
        } else {
            self.image = UIImage(systemName: "photo.artframe")
        }
        
        self.arrayModel = model
        super.init(nibName: nil, bundle: nil)
        arrayModel.delegate = self
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    // MARK: -
    // MARK: View Life Cycle

    override func viewDidLoad() {
        super.viewDidLoad()
        setUpTable()
        setUpNavBar()
        
        if let tableView = tableView {
            view.addSubview(tableView)
        }
    }

    // MARK: -
    // MARK: Private

    private func setUpNavBar() {
        
        let addButton = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(addNewCell))
        let sortButton = UIBarButtonItem(title: "Sort", style: .plain, target: self, action: #selector(sortCells))
        let editButton = UIBarButtonItem(barButtonSystemItem: .edit, target: self, action: #selector(toggleEditing))
        navigationItem.rightBarButtonItems = [addButton, sortButton]
        navigationItem.leftBarButtonItem = editButton
    }
    
    private func setUpTable() {
        self.tableView = UITableView(frame: view.bounds, style: .plain)
        self.tableView?.delegate = self
        self.tableView?.dataSource = self
        self.tableView?.register(CustomTableViewCell.nib, forCellReuseIdentifier: CustomTableViewCell.reuseIdentifier)
    }
    
    @objc private func toggleEditing() {
        self.tableView?.isEditing = !(tableView?.isEditing ?? false)
        navigationItem.rightBarButtonItem?.title = tableView?.isEditing ?? false ? "Done" : "Edit"
    }
    
    @objc private func addNewCell() {
        
        let newData = DataModel(text: UUID().uuidString, image: image)
        self.arrayModel.append(newData)
    }
    
    @objc private func sortCells() {
        self.arrayModel.sort()
        self.tableView?.reloadData()
    }
}

// MARK: -
// MARK: TableView Delegate

extension MainViewController: UITableViewDataSource, UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.arrayModel.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: CustomTableViewCell.reuseIdentifier, for: indexPath) as! CustomTableViewCell
        let dataModel = self.arrayModel[indexPath.row]
        cell.configure(with: dataModel)
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        return true
    }
    
    func tableView(_ tableView: UITableView, moveRowAt sourceIndexPath: IndexPath, to destinationIndexPath: IndexPath) {
        let movedObject = arrayModel[sourceIndexPath.row]
        arrayModel.remove(at: sourceIndexPath.row)
        arrayModel.array.insert(movedObject, at: destinationIndexPath.row)
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            self.arrayModel.remove(at: indexPath.row)
        } else if editingStyle == .insert {
            let newData = DataModel(text: UUID().uuidString, image: image)
            self.arrayModel.append(newData)
        }
    }
}

// MARK: -
// MARK: ArrayModelDelegate

extension MainViewController: ArrayModelDelegate {
    func arrayModelDidUpdate() {
        guard let tableView = self.tableView else { return }
        UIView.transition(with: tableView, duration: 1.0, options: .transitionCrossDissolve, animations: { tableView.reloadData() }, completion: nil)

    }
}
