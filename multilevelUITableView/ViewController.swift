//
//  ViewController.swift
//  multilevelUITableView
//
//  Created by Junyi Wang on 7/16/17.
//  Copyright © 2017 junyw. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    var dict = ViewController.exampleData()
    var dict2 = ViewController.exampleData()
    var dict3 = ViewController.exampleData()
    var collection = Collection()
    
    
    @IBOutlet weak var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        collection.dicts = [dict, dict2, dict3]
        
        // Do any additional setup after loading the view, typically from a nib.

        let cellNib = UINib(nibName: "CustomCell", bundle: nil)
        tableView.register(cellNib, forCellReuseIdentifier: "CustomCell")
        tableView.rowHeight = UITableViewAutomaticDimension
        tableView.estimatedRowHeight = 200
        
        tableView.setNeedsLayout()
        tableView.layoutIfNeeded()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    func collapseRows(_ tableView: UITableView, descendantsOf indexPath: IndexPath) {
        if let item = self.collection.getItem(indexPath) {
        let indexesToRemove: [IndexPath] = self.collection.collapseDescendants(inSection: indexPath.section, withId: item.id)
            tableView.deleteRows(at: indexesToRemove, with: UITableViewRowAnimation.none)
        }
    }
    func expandRows(_ tableView: UITableView, descendantsOf indexPath: IndexPath) {
        if let item = self.collection.getItem(indexPath) {
            let indexesToInsert: [IndexPath] = self.collection.expandDescendants(inSection: indexPath.section, withId: item.id)

            tableView.beginUpdates()
            tableView.insertRows(at: indexesToInsert, with: UITableViewRowAnimation.none)
            tableView.endUpdates()
        }
    }
    static func exampleData() -> Dictionary {
        let item1 = Item(id: 1, indent: 0, title: "title 0", text: "Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. ", descendants: [2, 8])
        let item2 = Item(id: 2, indent: 1, title: "title 1", text: "Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua.", descendants: [3, 4])
        let item3 = Item(id: 3, indent: 2, title: "title 2", text: "Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua.", descendants: [])
        let item4 = Item(id: 4, indent: 2, title: "title 3", text: "Duis aute irure dolor ", descendants: [5])
        let item5 = Item(id: 5, indent: 3, title: "title 4", text: "Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore", descendants: [6, 7])
        let item6 = Item(id: 6, indent: 4, title: "title 5", text: "Ut enim ad minim veniam, quis nostrud exercitation ullamco ", descendants: [])
        let item7 = Item(id: 7, indent: 4, title: "title 6", text: "Ut enim ad minim veniam, quis nostrud exercitation ullamco", descendants: [])
        let item8 = Item(id: 8, indent: 1, title: "title 8", text: "Ut enim ad", descendants: [])

        let dict = Dictionary()
        dict.addItemToLast(item1)
        dict.addItemToLast(item2)
        dict.addItemToLast(item3)
        dict.addItemToLast(item4)
        dict.addItemToLast(item5)
        dict.addItemToLast(item6)
        dict.addItemToLast(item7)
        dict.addItemToLast(item8)

        return dict
    }
}
extension ViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let cell: CustomCell = tableView.cellForRow(at: indexPath) as! CustomCell
        if self.collection.isCollapsed(indexPath) {
            cell.detailLabel.text = self.collection.getItem(indexPath)?.text
            self.expandRows(tableView, descendantsOf: indexPath)
        } else {
            cell.detailLabel.text = ""
            self.collapseRows(tableView, descendantsOf: indexPath)
        }
    }
}
extension ViewController: UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return self.collection.numberOfSections()
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.collection.numberOfRowsInSection(section)
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cellIdentifier = "CustomCell"
        let cell: CustomCell! = tableView.dequeueReusableCell(withIdentifier: cellIdentifier, for: indexPath) as! CustomCell

        if let item = self.collection.getItem(indexPath) {
            cell.titleLabel.text = item.title
            if let indent = item.indent {
                cell.indentationLevel = indent
            }

            if !item.collapsed {
                cell.detailLabel.text = item.text
            } else {
                cell.detailLabel.text = ""
            }
        }
        return cell
    }
}



