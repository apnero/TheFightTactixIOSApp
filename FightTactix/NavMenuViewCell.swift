//
//  NavMenuViewCell.swift
//  FightTactix
//
//  Created by Andrew Nero on 12/7/15.
//  Copyright © 2015 Andrew Nero. All rights reserved.
//


import UIKit

class NavMenuViewCell: UITableViewCell {
    
    let padding: CGFloat = 5
    var background: UIView!
    var menuLabel: UILabel!
    var creditLabel: UILabel!
    
    
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        backgroundColor = UIColor.clearColor()
        selectionStyle = .None
        
        background = UIView(frame: CGRectZero)
        background.alpha = 0.6
        contentView.addSubview(background)
        
        
        menuLabel = UILabel(frame: CGRectZero)
        menuLabel.textAlignment = .Center
        menuLabel.textColor = UIColor.whiteColor()
        menuLabel.backgroundColor = UIColor.greenColor()
        contentView.addSubview(menuLabel)
        
        creditLabel = UILabel(frame: CGRectZero)
        creditLabel.textAlignment = .Center
        creditLabel.textColor = UIColor.whiteColor()
        creditLabel.backgroundColor = UIColor.orangeColor()
        contentView.addSubview(creditLabel)
    }
    
    required init(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        background.frame = CGRectMake(0, padding, frame.width, frame.height - 2 * padding)
        menuLabel.frame = CGRectMake(padding, (frame.height - 25)/2, 40, 25)
        creditLabel.frame = CGRectMake(frame.width - 100, padding, 100, frame.height - 2 * padding)
      
    }
    
}
