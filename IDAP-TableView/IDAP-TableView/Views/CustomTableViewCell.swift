//
//  CustomTableViewCell.swift
//  IDAP-TableView
//
//  Created by Dmytro Akulinin on 26.05.2023.
//

import UIKit

class CustomTableViewCell: BaseTableViewCell {
    var dataModel: DataModel?
    
    @IBOutlet var cellImage: UIImageView?
    @IBOutlet var cellText: UILabel?
    
    func configure(with model: DataModel) {
        self.dataModel = model
        cellText?.text = model.text
        cellImage?.image = model.image
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
}
