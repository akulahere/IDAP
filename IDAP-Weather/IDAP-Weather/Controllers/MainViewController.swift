//
//  ViewController.swift
//  IDAP-Weather
//
//  Created by Dmytro Akulinin on 01.06.2023.
//

import UIKit

class MainViewController: UIViewController, RootViewGettable, MainViewDelegate {
    typealias RootViewType = MainView

    override func viewDidLoad() {
        super.viewDidLoad()
        self.rootView?.delegate = self
    }
    
//    override func loadView() {
//        self.rootView?.delegate = self
//    }

}

// MARK: -
// MARK: TableView Delegate

extension MainViewController: UITableViewDataSource, UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell: CustomTableViewCell = tableView.dequeueReusableCell(for: indexPath)
//        let dataModel = self.arrayModel[indexPath.row]
//        cell.configure(with: dataModel)

        return cell
    }

    
    func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        return true
    }

    
}
