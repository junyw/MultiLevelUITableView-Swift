//
//  ViewController.swift
//  multilevelUITableView
//
//  Created by Junyi Wang on 7/16/17.
//  Copyright © 2017 junyw. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    var dict = Dictionary()
    let item1 = Item(id: 0, indent: 0, title: "title 0", descendants: [1])
    let item2 = Item(id: 1, indent: 1, title: "title 1", descendants: [2])
    let item3 = Item(id: 2, indent: 2, title: "title 2", descendants: [])
    
    
    @IBOutlet weak var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        dict.addItemToLast(item1, id: item1.id)
        dict.addItemToLast(item2, id: item2.id)
        dict.addItemToLast(item3, id: item3.id)

        let cellNib = UINib(nibName: "CustomCell", bundle: nil)
        tableView.register(cellNib, forCellReuseIdentifier: "CustomCell")

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
                tableView.deleteRows(at: indexesToRemove, with: UITableViewRowAnimation.right)
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
                tableView.insertRows(at: indexesToInsert, with: UITableViewRowAnimation.left)
                tableView.endUpdates()
            }
        }
    }
}
extension ViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print(indexPath.section)
        print(indexPath.row)
        if self.dict.isCollapsed(atRow: indexPath.row) {
            self.expandRows(tableView, descendantsOf: indexPath.row)
        } else {
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
        
        let queue = DispatchQueue.global()

        queue.async {
            let item = self.dict.getItem(atRow: indexPath.row)
            print("\(item)")
            DispatchQueue.main.async {
                cell.detailLabel.text = item?.title
                if let indent = item?.indent {
                    print(indent)
                    cell.indentationLevel = indent
                    cell.contentView.backgroundColor = UIColor.black.withAlphaComponent(CGFloat(indent)/50.0)
                }
            }
        }
        
        return cell
    }
}
