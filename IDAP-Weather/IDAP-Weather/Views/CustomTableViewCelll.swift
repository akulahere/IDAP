//
//  MainViewTableViewCell.swift
//  IDAP-Weather
//
//  Created by Dmytro Akulinin on 01.06.2023.
//

import UIKit

class CustomTableViewCell: UITableViewCell {
    
    @IBOutlet var iconImageView: UIImageView?
    @IBOutlet var weatherName: UILabel?
    
    func configure(model: Forecast, icon: UIImage?) {
        self.weatherName?.text = model.weather
        self.iconImageView?.image = icon
    }
}
