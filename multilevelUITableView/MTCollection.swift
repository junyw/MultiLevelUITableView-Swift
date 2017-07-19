//
//  MTCollection.swift
//  multilevelUITableView
//
//  Created by Junyi Wang on 7/18/17.
//  Copyright © 2017 junyw. All rights reserved.
//

import Foundation

class MTCollection {
    var sections: [MTDictionary] = []
    
    func numberOfSections() -> Int {
        return sections.count
    }
    func numberOfRowsInSection(_ section: Int) -> Int {
        return sections[section].count()
    }
    func getItem(_ indexPath: IndexPath) -> MTItem? {
        return sections[indexPath.section].getItem(atRow: indexPath.row)
    }
    func isCollapsed(_ indexPath: IndexPath) -> Bool {
        return sections[indexPath.section].isCollapsed(atRow: indexPath.row)
    }
    func collapseDescendants(inSection section: Int, withId id: Int) -> [IndexPath] {
        let dict = sections[section]
        let rows =  dict.collapseDescendants(ofId: id)
        var indexesToRemove: [IndexPath] = []
        for row in rows {
            indexesToRemove.append(IndexPath(row: row, section: section))
        }
        return indexesToRemove
    }
    func expandDescendants(inSection section: Int, withId id: Int) -> [IndexPath] {
        let dict = sections[section]
        let rows = dict.expandDescendants(ofId: id)
        var indexesToRemove: [IndexPath] = []
        for row in rows {
            indexesToRemove.append(IndexPath(row: row, section: section))
        }
        return indexesToRemove
    }
}
