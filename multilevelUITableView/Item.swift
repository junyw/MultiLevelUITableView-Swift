//
//  Item.swift
//  multilevelUITableView
//
//  Created by Junyi Wang on 7/16/17.
//  Copyright © 2017 junyw. All rights reserved.
//

import Foundation

class Item {
    init(id: Int, indent: Int, title: String, descendants: [Int]) {
        self.id = id
        self.indent = indent
        self.title = title
        self.descendants = descendants
    }

    var id: Int
    var descendants: [Int] = []
    var indent: Int?
    var title: String?
    var collapsed: Bool = false
}
