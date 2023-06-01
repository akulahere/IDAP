//
//  ArrayModel.swift
//  IDAP-TableView
//
//  Created by Dmytro Akulinin on 26.05.2023.
//

import UIKit

protocol ArrayModelDelegate: AnyObject {
    func arrayModelDidUpdate()
}

class ArrayModel {
    
    // MARK: -
    // MARK: Variables
    
    weak var delegate: ArrayModelDelegate?

    var array: [DataModel] {
        didSet {
            self.delegate?.arrayModelDidUpdate()
        }
    }
    
    deinit {
        print("Model deinit")
    }
    
    var ascSortOrder = true

    var count: Int {
        return self.array.count
    }
    
    // MARK: -
    // MARK: Initialization and Deallocation
    
    init(array: [DataModel]) {
        self.array = array
    }

    // MARK: -
    // MARK: Public
    
    subscript(index: Int) -> DataModel {
        get { return array[index] }
        set(newValue) {
            self.array[index] = newValue
        }
    }

    func append(_ newItem: DataModel) {
        self.array.append(newItem)
    }

    func remove(at index: Int) {
        self.array.remove(at: index)
    }
    
    func sort() {
        if ascSortOrder {
            self.array.sort { $0.text < $1.text }
            self.ascSortOrder.toggle()
        } else {
            self.array.sort { $0.text > $1.text}
            self.ascSortOrder.toggle()
        }
    }
}
