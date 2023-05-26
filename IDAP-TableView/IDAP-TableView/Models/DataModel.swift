//
//  DataModel.swift
//  IDAP-TableView
//
//  Created by Dmytro Akulinin on 26.05.2023.
//

import UIKit

class DataModel {
    var text: String
    var image: UIImage?

    init(text: String, image: UIImage?) {
        self.text = text
        self.image = image
    }
}
