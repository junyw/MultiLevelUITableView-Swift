//
//  Collection.swift
//  multilevelUITableView
//
//  Created by Junyi Wang on 7/18/17.
//  Copyright © 2017 junyw. All rights reserved.
//

import Foundation

class Collection {
    var dicts: [Dictionary] = []
    
    func numberOfSections() -> Int {
        return dicts.count
    }
    func numberOfRowsInSection(_ section: Int) -> Int {
        return dicts[section].count()
    }
    func getItem(_ indexPath: IndexPath) -> Item? {
        return dicts[indexPath.section].getItem(atRow: indexPath.row)
    }
    func isCollapsed(_ indexPath: IndexPath) -> Bool {
        return dicts[indexPath.section].isCollapsed(atRow: indexPath.row)
    }
    func collapseDescendants(inSection section: Int, withId id: Int) -> [IndexPath] {
        let dict = dicts[section]
        let rows =  dict.collapseDescendants(ofId: id)
        var indexesToRemove: [IndexPath] = []
        for row in rows {
            indexesToRemove.append(IndexPath(row: row, section: section))
        }
        return indexesToRemove
    }
    func expandDescendants(inSection section: Int, withId id: Int) -> [IndexPath] {
        let dict = dicts[section]
        let rows = dict.expandDescendants(ofId: id)
        var indexesToRemove: [IndexPath] = []
        for row in rows {
            indexesToRemove.append(IndexPath(row: row, section: section))
        }
        return indexesToRemove
    }
}
