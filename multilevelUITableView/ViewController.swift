//
//  ViewController.swift
//  multilevelUITableView
//
//  Created by Junyi Wang on 7/16/17.
//  Copyright © 2017 junyw. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    var items: [Item] = []
    let item1 = Item(id: 0, indent: 0, title: "title 0", descendants: [1])
    let item2 = Item(id: 1, indent: 1, title: "title 1", descendants: [])
    let item3 = Item(id: 2, indent: 2, title: "title 2", descendants: [])

    
    @IBOutlet weak var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        items.append(item1)
        items.append(item2)
        items.append(item3)
        let cellNib = UINib(nibName: "CustomCell", bundle: nil)
        tableView.register(cellNib, forCellReuseIdentifier: "CustomCell")

    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}
extension ViewController: UITableViewDelegate {
}
extension ViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.items.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cellIdentifier = "CustomCell"
        let cell: CustomCell! = tableView.dequeueReusableCell(withIdentifier: cellIdentifier, for: indexPath) as! CustomCell
        
        let queue = DispatchQueue.global()

        queue.async {
            let item = self.items[indexPath.row]
            print("\(item)")
            DispatchQueue.main.async {
                cell.detailLabel.text = item.title
                cell.indentationWidth = 20;

                if let indent = item.indent {
                    print(indent)
                    cell.indentationLevel = indent
                }
            }
        }
        
        return cell
    }
}
