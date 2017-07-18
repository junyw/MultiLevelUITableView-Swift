//
//  Dictionary.swift
//  multilevelUITableView
//
//  Created by Junyi Wang on 7/17/17.
//  Copyright © 2017 junyw. All rights reserved.
//

import Foundation

class Dictionary {
    var _indexes: [Int] = []
    var objects: [Int: Item] = [:]
    func count() -> Int {
        return _indexes.count
    }
    func expandDescendants(ofId id: Int) -> [Int]? {
        if let item = self.getItem(withId: id) {
            item.collapsed = false
            
            insertAllDescendants(ofId: id)
            print(_indexes)
            let rows = getRowOfAllDescendants(ofId: id)
            return rows
        }
        return []
    }
    func insertAllDescendants(ofId id: Int) {
        
        if let item = self.getItem(withId: id) {
            
            let row = self.getRow(ofId: id)!
            if !item.collapsed {
                let descendants = item.descendants
                var counter = row + 1
                for childId in descendants {
                    if let child = getItem(withId: childId) {
                        // add this child back to _indexes
                        _indexes.insert(childId, at: counter)
                        counter += 1
                        if !child.collapsed {
                            insertAllDescendants(ofId: childId)
                        }
                    }
                }
                item.collapsed = false
            }
        }
    }
    func collapseDescendants(ofId id: Int) -> [Int]? {
        if let item = self.getItem(withId: id) {
            if item.collapsed {
                return nil
            } else {
                let rows = getRowOfAllDescendants(ofId: id)
                removeAllDescendants(ofId: id)
                item.collapsed = true
                return rows
            }
        }
        return nil
    }
    func getRowOfAllDescendants(ofId id: Int) -> [Int]? {
        var results: [Int] = []
        if let item = getItem(withId: id) {
            for childId in item.descendants {
                if let rows = getAllRows(ofId: childId) {
                    results.append(contentsOf: rows)
                }
            }
        }
        return results
    }
    func removeAllDescendants(ofId id: Int) {
        if let item = self.getItem(withId: id) {
            let descendants = item.descendants
            for childId in descendants {
                removeAll(ofId: childId)
            }
        }
    }
    func removeAll(ofId id: Int) {
        if let item = self.getItem(withId: id) {
            if let id = _indexes.index(of: id) {
                _indexes.remove(at: id)

            }
            let descendants = item.descendants
            for childId in descendants {
                removeAll(ofId: childId)
            }
        }
    }
    func getItem(atRow row: Int) -> Item? {
        return objects[_indexes[row]]
    }
    func getRow(ofId id: Int) -> Int? {
        return _indexes.index(of: id)
    }
    func getRows(ofIds ids: [Int]) -> [Int]? {
        var results: [Int] = []
        for id in ids {
            results.append(getRow(ofId: id)!)
        }
        return results
    }
    func getAllRows(ofId id: Int) -> [Int]? {
        var results: [Int] = []
        if let item = self.getItem(withId: id), !item.collapsed {
            let descendants = item.descendants
            for childId in descendants {
                let rows: [Int] = self.getAllRows(ofId: childId)!
                results.append(contentsOf: rows)
            }
        }
        if let row = getRow(ofId: id) {
            results.append(row)
        }
        return results
    }
    func getItem(withId id: Int) -> Item? {
        return objects[id]
    }
    func getDescendants(of id: Int) -> [Int]? {
        return objects[id]!.descendants
    }
    func addItemToLast(_ item: Item) {
        objects[item.id] = item
        _indexes.append(item.id)
    }
    func isCollapsed(atRow row: Int) -> Bool {
        let item = getItem(atRow: row)
        return (item?.collapsed)!
    }
}


