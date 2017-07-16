//
//  CustomCell.swift
//  multilevelUITableView
//
//  Created by Junyi Wang on 7/16/17.
//  Copyright © 2017 junyw. All rights reserved.
//

import UIKit

class CustomCell: UITableViewCell {
    
    @IBOutlet weak var detailLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        let selectedView = UIView(frame: CGRect.zero)
        selectedView.backgroundColor = UIColor(red: 20/255, green: 160/255, blue: 160/255, alpha: 0.5)
        selectedBackgroundView = selectedView
        
        self.indentationWidth = 10.0

    }
    override func layoutSubviews() {
        super.layoutSubviews()
        let xContentOffset: CGFloat = CGFloat(self.indentationLevel)*self.indentationWidth;
        var contentFrame: CGRect = self.contentView.frame
        contentFrame.origin.x = xContentOffset
        contentFrame.size.width -= xContentOffset
        self.contentView.frame = contentFrame
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        // Configure the view for the selected state
    }
    
}

