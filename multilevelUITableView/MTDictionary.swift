//
//  MTDictionary.swift
//  multilevelUITableView
//
//  Created by Junyi Wang on 7/17/17.
//  Copyright © 2017 junyw. All rights reserved.
//

import Foundation

class MTDictionary {
    var rows: [Int] = []
    var objects: [Int: MTItem] = [:]
    func count() -> Int {
        return rows.count
    }
    func expandDescendants(ofId id: Int) -> [Int] {
        if let item = self.getItem(withId: id) {
            item.collapsed = false
            
            if insertAllDescendants(ofId: id) > 0 {
                let rows = getRowOfAllDescendants(ofId: id)
                return rows
            }
        }
        return []
    }
    
    func insertAllDescendants(ofId id: Int) -> Int {
        
        if let item = self.getItem(withId: id) {
            
            if let row = self.getRow(ofId: id) {
                if !item.collapsed {
                    let descendants = item.descendants
                    var position = row + 1
                    for childId in descendants {
                        // add this child back to rows
                        if let child = getItem(withId: childId) {
                            if child.collapsed {
                                rows.insert(childId, at: position)
                                position += 1
                            } else {
                                rows.insert(childId, at: position)
                                position = insertAllDescendants(ofId: childId)
                            }
                        }
                    }
                    item.collapsed = false
                    return position
                }
            }
        }
        return 0
    }
    func collapseDescendants(ofId id: Int) -> [Int] {
        if let item = self.getItem(withId: id) {
            if item.collapsed {
                return []
            } else {
                let rows = getRowOfAllDescendants(ofId: id)
                removeAllDescendants(ofId: id)
                item.collapsed = true
                return rows
            }
        }
        return []
    }
    func getRowOfAllDescendants(ofId id: Int) -> [Int] {
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
            if let id = rows.index(of: id) {
                rows.remove(at: id)

            }
            let descendants = item.descendants
            for childId in descendants {
                removeAll(ofId: childId)
            }
        }
    }
    func getItem(atRow row: Int) -> MTItem? {
        return objects[rows[row]]
    }
    func getRow(ofId id: Int) -> Int? {
        return rows.index(of: id)
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
    func getItem(withId id: Int) -> MTItem? {
        return objects[id]
    }
    func getDescendants(of id: Int) -> [Int]? {
        return objects[id]!.descendants
    }
    func addItemToLast(_ item: MTItem) {
        objects[item.id] = item
        rows.append(item.id)
    }
    func isCollapsed(atRow row: Int) -> Bool {
        let item = getItem(atRow: row)
        return (item?.collapsed)!
    }
}


