//
//  CustomCell.swift
//  multilevelUITableView
//
//  Created by Junyi Wang on 7/16/17.
//  Copyright © 2017 junyw. All rights reserved.
//

import UIKit

class CustomCell: UITableViewCell {
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var detailLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        backgroundView = BackgroudView()
        self.selectionStyle = .none
        self.indentationWidth = 10.0

    }
    override func layoutSubviews() {
        super.layoutSubviews()
        self.contentView.layoutIfNeeded()

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
class BackgroudView: UIView {
    public init() {
        super.init(frame: CGRect(x: 0, y: 0, width: 480, height: 320))
        backgroundColor = UIColor.white
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func draw(_ rect: CGRect) {
        
        let aPath = UIBezierPath()
        aPath.lineWidth = 1
        let height = rect.height
        var xPos = CGFloat(8.0)
        while xPos < rect.width {
            aPath.move(to: CGPoint(x:xPos, y:0.0))
            aPath.addLine(to: CGPoint(x:xPos, y:height))
            xPos += 10.0
        }
//        aPath.move(to: CGPoint(x:8.0, y:0.0))
//        
//        aPath.addLine(to: CGPoint(x:8.0, y:height))
//
//        aPath.move(to: CGPoint(x:18.0, y:0.0))
//        
//        aPath.addLine(to: CGPoint(x:18.0, y:height))
//
//        aPath.move(to: CGPoint(x:28.0, y:0.0))
//        
//        aPath.addLine(to: CGPoint(x:28.0, y:height))

        //Keep using the method addLineToPoint until you get to the one where about to close the path
        
        aPath.close()
        
        //If you want to stroke it with a red color
        UIColor.black.withAlphaComponent(0.05).set()
        aPath.stroke()
        //If you want to fill it as well
        aPath.fill()

    }
}
