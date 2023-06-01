//
//  ViewController.swift
//  IDAP-TableView
//
//  Created by Dmytro Akulinin on 26.05.2023.
//

import UIKit

class MainViewController: UIViewController, MainViewDelegate, RootViewGettable {
    typealias RootViewType = MainView
    

    // MARK: -
    // MARK: Variables

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
        self.arrayModel.delegate = self
        self.rootView?.delegate = self
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    // MARK: -
    // MARK: View Life Cycle

    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.rootView?.setUpTable(delegate: self)
        self.rootView?.setUpNavBar(delegate: self)
        
    }

    // MARK: -
    // MARK: Public
    
    @objc func toggleEditing() {
        self.rootView?.tableView?.isEditing = !(rootView?.tableView?.isEditing ?? false)
        self.navigationItem.rightBarButtonItem?.title = rootView?.tableView?.isEditing ?? false ? "Done" : "Edit"
    }
    
    @objc func addNewCell() {
        let newData = DataModel(text: UUID().uuidString, image: image)
        self.arrayModel.append(newData)
    }

    
    @objc func sortCells() {
        self.arrayModel.sort()
    }
}

// MARK: -
// MARK: TableView Delegate

extension MainViewController: UITableViewDataSource, UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.arrayModel.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell: CustomTableViewCell = tableView.dequeueReusableCell(for: indexPath)
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
        rootView?.reloadTable()
    }
}
