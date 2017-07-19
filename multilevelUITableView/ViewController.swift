//
//  ViewController.swift
//  multilevelUITableView
//
//  Created by Junyi Wang on 7/16/17.
//  Copyright © 2017 junyw. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    var collection = ExampleData.example()
    
    @IBOutlet weak var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
                
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



