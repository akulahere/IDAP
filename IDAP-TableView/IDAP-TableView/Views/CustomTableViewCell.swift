//
//  CustomTableViewCell.swift
//  IDAP-TableView
//
//  Created by Dmytro Akulinin on 26.05.2023.
//

import UIKit

class CustomTableViewCell: UITableViewCell {
    var dataModel: DataModel?
    
    @IBOutlet var cellImage: UIImageView?
    @IBOutlet var cellText: UILabel?
    
    func configure(with model: DataModel) {
        self.dataModel = model
        self.cellText?.text = model.text
        self.cellImage?.image = model.image
    }
}
