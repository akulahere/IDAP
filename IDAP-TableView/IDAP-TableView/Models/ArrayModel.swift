//
//  ArrayModel.swift
//  IDAP-TableView
//
//  Created by Dmytro Akulinin on 26.05.2023.
//

import UIKit

class ArrayModel {
    var array: [DataModel]
    var ascSortOrder = true

    init(array: [DataModel]) {
        self.array = array
    }

    subscript(index: Int) -> DataModel {
        get { return array[index] }
        set(newValue) { array[index] = newValue }
    }

    var count: Int {
        return array.count
    }

    func append(_ newItem: DataModel) {
        array.append(newItem)
    }

    func remove(at index: Int) {
        array.remove(at: index)
    }
    
    func sort() {
        if ascSortOrder {
            array.sort { $0.text < $1.text }
            ascSortOrder.toggle()
        } else {
            array.sort { $0.text > $1.text}
            ascSortOrder.toggle()
        }
    }
}
