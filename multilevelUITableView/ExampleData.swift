//
//  ExampleData.swift
//  MultiLevelUITableView
//
//  Created by Junyi Wang on 7/19/17.
//  Copyright © 2017 junyw. All rights reserved.
//

import Foundation

class ExampleData {
    static func example() -> MTCollection {
        var collection = MTCollection()
        let dict1 = exampleSection1()
        let dict2 = exampleSection2()
        let dict3 = exampleSection1()
        let dict4 = exampleSection2()
        collection.sections = [dict1, dict2, dict3, dict4]
        return collection
    }
    static func exampleSection1() -> MTDictionary {
        let dict = MTDictionary()
        
        let item1 = MTItem(id: 1, indent: 0, title: "title 0", text: "Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. ", descendants: [2, 8])
        let item2 = MTItem(id: 2, indent: 1, title: "title 1", text: "Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua.", descendants: [3, 4])
        let item3 = MTItem(id: 3, indent: 2, title: "title 2", text: "Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua.", descendants: [])
        let item4 = MTItem(id: 4, indent: 2, title: "title 3", text: "Duis aute irure dolor ", descendants: [5])
        let item5 = MTItem(id: 5, indent: 3, title: "title 4", text: "Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore", descendants: [6, 7])
        let item6 = MTItem(id: 6, indent: 4, title: "title 5", text: "Ut enim ad minim veniam, quis nostrud exercitation ullamco ", descendants: [])
        let item7 = MTItem(id: 7, indent: 4, title: "title 6", text: "Ut enim ad minim veniam, quis nostrud exercitation ullamco", descendants: [])
        let item8 = MTItem(id: 8, indent: 1, title: "title 8", text: "Ut enim ad", descendants: [9])
        let item9 = MTItem(id: 9, indent: 2, title: "title 9", text: "Ut enim ad", descendants: [])
    
        dict.addItemToLast(item1)
        dict.addItemToLast(item2)
        dict.addItemToLast(item3)
        dict.addItemToLast(item4)
        dict.addItemToLast(item5)
        dict.addItemToLast(item6)
        dict.addItemToLast(item7)
        dict.addItemToLast(item8)
        dict.addItemToLast(item9)
        return dict
    }
    static func exampleSection2() -> MTDictionary {
        let dict = MTDictionary()
        
        let item1 = MTItem(id: 1, indent: 0, title: "title 0", text: "Fusce ut porttitor est, non iaculis metus. Aliquam ut leo id elit pharetra viverra vel a dolor. Aliquam porttitor urna a turpis molestie luctus eu et ante. ", descendants: [2])
        let item2 = MTItem(id: 2, indent: 1, title: "title 1", text: "Fusce ut porttitor est.", descendants: [3])
        let item3 = MTItem(id: 3, indent: 2, title: "title 2", text: "Aliquam sit amet sapien mattis, varius nunc ac, congue mi. ", descendants: [4])
        let item4 = MTItem(id: 4, indent: 2, title: "title 3", text: "Aliquam sit amet sapien mattis, varius nunc ac, congue mi. ", descendants: [])
        
        dict.addItemToLast(item1)
        dict.addItemToLast(item2)
        dict.addItemToLast(item3)
        dict.addItemToLast(item4)
        return dict
    }

}
