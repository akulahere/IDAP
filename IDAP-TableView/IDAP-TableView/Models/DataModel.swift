//
//  DataModel.swift
//  IDAP-TableView
//
//  Created by Dmytro Akulinin on 26.05.2023.
//

import UIKit

class DataModel {
    
    // MARK: -
    // MARK: Variables

    var text: String
    var image: UIImage?

    // MARK: -
    // MARK: Initializations and Deallocations

    init(text: String, image: UIImage?) {
        self.text = text
        self.image = image
    }
}
