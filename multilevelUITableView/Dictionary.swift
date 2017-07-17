//
//  Dictionary.swift
//  multilevelUITableView
//
//  Created by Junyi Wang on 7/17/17.
//  Copyright © 2017 junyw. All rights reserved.
//

import Foundation

class Dictionary {
    var indexes: [Int] = []
    var _indexes: [Int] = []
    var objects: [Int: Item] = [:]
    func count() -> Int {
        return indexes.count
    }
    func _count() -> Int {
        return _indexes.count
    }
    func getItem(atRow row: Int) -> Item? {
        return objects[_indexes[row]]
    }
    func getRow(ofId id: Int) -> Int? {
        return _indexes.index(of: id)
    }
    func getItem(withId id: Int) -> Item? {
        return objects[id]
    }
    func getDescendants(of id: Int) -> [Int]? {
        return objects[id]!.descendants!
    }
    func addItemToLast(_ item: Item, id: Int) {
        objects[id] = item
        indexes.append(id)
        _indexes.append(id)
    }
    func isCollapsed(_ id: Int) -> Bool {
        return objects[id]!.collapsed
    }
    
    func collapse(descendantsOf id: Int) {
        let descendants = objects[id]?.descendants
        for id in descendants! {
            if let index = _indexes.index(of: id) {
                _indexes.remove(at: index)
            }
        }
        objects[id]?.collapsed = true
    }
    func show(descendantsOf id: Int) {
        let descendants = objects[id]?.descendants
        if let rowOfParent = _indexes.index(of: id) {
            var count = rowOfParent
            for id in descendants! {
                _indexes.insert(id, at: count)
                count = count + 1
            }
        }
        objects[id]?.collapsed = false

    }
}
