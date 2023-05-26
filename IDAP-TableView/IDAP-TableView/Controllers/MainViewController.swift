//
//  ViewController.swift
//  IDAP-TableView
//
//  Created by Dmytro Akulinin on 26.05.2023.
//

import UIKit

class MainViewController: UIViewController {
    var tableView: UITableView!
    var arrayModel: ArrayModel!
    var image: UIImage!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.image = loadImage()
        
        let dataModels = (0..<10).map { _ in DataModel(text: UUID().uuidString, image: image) }
        arrayModel = ArrayModel(array: dataModels)
        self.tableView = UITableView(frame: view.bounds, style: .plain)
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(CustomTableViewCell.nib, forCellReuseIdentifier: CustomTableViewCell.reuseIdentifier)
        view.addSubview(tableView)
        let addButton = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(addNewCell))
        let sortButton = UIBarButtonItem(title: "Sort", style: .plain, target: self, action: #selector(sortCells))
        navigationItem.rightBarButtonItems = [addButton, sortButton]
        navigationItem.leftBarButtonItem = UIBarButtonItem(barButtonSystemItem: .edit, target: self, action: #selector(toggleEditing))
    }
    
   
    func loadImage() -> UIImage {
        return UIImage(named: "pepe")!
    }
}

extension MainViewController: UITableViewDataSource, UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return arrayModel.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: CustomTableViewCell.reuseIdentifier, for: indexPath) as! CustomTableViewCell
        let dataModel = arrayModel[indexPath.row]
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
            arrayModel.remove(at: indexPath.row)
            tableView.deleteRows(at: [indexPath], with: .fade)
        } else if editingStyle == .insert {
            let newData = DataModel(text: UUID().uuidString, image: image)
            arrayModel.append(newData)
            tableView.insertRows(at: [IndexPath(row: arrayModel.count - 1, section: 0)], with: .automatic)
        }
    }
 
    @objc func toggleEditing() {
        tableView.isEditing = !tableView.isEditing
        navigationItem.rightBarButtonItem?.title = tableView.isEditing ? "Done" : "Edit"
    }
    
    @objc func addNewCell() {
        let newData = DataModel(text: UUID().uuidString, image: image)
        arrayModel.append(newData)
        tableView.insertRows(at: [IndexPath(row: arrayModel.count - 1, section: 0)], with: .automatic)
    }
    
    @objc func sortCells() {
        arrayModel.sort()
        tableView.reloadData()
    }
}
