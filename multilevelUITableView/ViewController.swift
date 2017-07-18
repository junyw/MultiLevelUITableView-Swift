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
    
    @IBOutlet weak var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.

        let cellNib = UINib(nibName: "CustomCell", bundle: nil)
        tableView.register(cellNib, forCellReuseIdentifier: "CustomCell")
        tableView.rowHeight = UITableViewAutomaticDimension
        tableView.estimatedRowHeight = 80
        
        tableView.setNeedsLayout()
        tableView.layoutIfNeeded()

    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    func collapseRows(_ tableView: UITableView, descendantsOf row: Int) {
        if let item = self.dict.getItem(atRow: row) {
            
            if let rows: [Int] = self.dict.collapseDescendants(ofId: item.id) {
                var indexesToRemove: [IndexPath] = []
                for row in rows {
                    indexesToRemove.append(IndexPath(row: row, section: 0))
                }
                tableView.deleteRows(at: indexesToRemove, with: UITableViewRowAnimation.automatic)
            }
        }
    }
    func expandRows(_ tableView: UITableView, descendantsOf row: Int) {
        if let item = self.dict.getItem(atRow: row) {
            if let rows: [Int] = self.dict.expandDescendants(ofId: item.id) {

                var indexesToInsert: [IndexPath] = []
                for row in rows {
                    indexesToInsert.append(IndexPath(row: row, section: 0))
                }
                tableView.beginUpdates()
                tableView.insertRows(at: indexesToInsert, with: UITableViewRowAnimation.automatic)
                tableView.endUpdates()
            }
        }
    }
    static func exampleData() -> Dictionary {
        let item1 = Item(id: 1, indent: 0, title: "title 0", text: "Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. ", descendants: [2])
        let item2 = Item(id: 2, indent: 1, title: "title 1", text: "Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua.", descendants: [3, 4])
        let item3 = Item(id: 3, indent: 2, title: "title 1", text: "Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua.", descendants: [])
        let item4 = Item(id: 4, indent: 2, title: "title 2", text: "Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore", descendants: [5])
        let item5 = Item(id: 5, indent: 3, title: "title 2", text: "Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore", descendants: [])
        let item6 = Item(id: 6, indent: 0, title: "title 3", text: "Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore", descendants: [7])
        let item7 = Item(id: 7, indent: 1, title: "title 4", text: "Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore", descendants: [])
        let dict = Dictionary()
        dict.addItemToLast(item1)
        dict.addItemToLast(item2)
        dict.addItemToLast(item3)
        dict.addItemToLast(item4)
        dict.addItemToLast(item5)
        dict.addItemToLast(item6)
        dict.addItemToLast(item7)
        return dict
    }
}
extension ViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let cell: CustomCell = tableView.cellForRow(at: indexPath) as! CustomCell
        if self.dict.isCollapsed(atRow: indexPath.row) {
            cell.detailLabel.text = self.dict.getItem(atRow: indexPath.row)?.text
            self.expandRows(tableView, descendantsOf: indexPath.row)
        } else {
            cell.detailLabel.text = ""
            self.collapseRows(tableView, descendantsOf: indexPath.row)
        }
    }
}
extension ViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.dict.count()
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cellIdentifier = "CustomCell"
        let cell: CustomCell! = tableView.dequeueReusableCell(withIdentifier: cellIdentifier, for: indexPath) as! CustomCell

        let item = self.dict.getItem(atRow: indexPath.row)
        cell.titleLabel.text = item?.title
        cell.detailLabel.text = item?.text
        if let indent = item?.indent {
            cell.indentationLevel = indent
//            cell.contentView.backgroundColor = UIColor.black.withAlphaComponent(CGFloat(indent)/50.0)
        }
//        cell.layoutSubviews()

        return cell
    }
}



