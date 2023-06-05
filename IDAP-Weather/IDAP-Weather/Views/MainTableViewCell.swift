//
//  MainTableViewCell.swift
//  IDAP-Weather
//
//  Created by Dmytro Akulinin on 05.06.2023.
//

import UIKit


class MainTableViewCell: UITableViewCell {
    
    @IBOutlet var iconImageView: UIImageView?
    @IBOutlet var weatherName: UILabel?
    @IBOutlet weak var tempLabel: UILabel?
    @IBOutlet weak var timeLabel: UILabel?
    
    //    override func awakeFromNib() {
//        super.awakeFromNib()
//    }
    
//    override func setSelected(_ selected: Bool, animated: Bool) {
//        super.setSelected(selected, animated: animated)
//        
//    }
    

    
    func configure(model: Forecast, icon: UIImage?) {
        self.weatherName?.text = model.weather
        self.iconImageView?.image = icon
        self.tempLabel?.text = String(model.temp)
        self.timeLabel?.text = model.time
    }
}

