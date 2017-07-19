//
//  MTItem.swift
//  multilevelUITableView
//
//  Created by Junyi Wang on 7/16/17.
//  Copyright © 2017 junyw. All rights reserved.
//

import Foundation

class MTItem {
    init(id: Int, indent: Int, title: String, text: String, descendants: [Int]) {
        self.id = id
        self.indent = indent
        self.title = title
        self.text = text
        self.descendants = descendants
    }

    var id: Int
    var descendants: [Int] = []
    var indent: Int?
    var title: String?
    var text: String?
    var collapsed: Bool = false
}
