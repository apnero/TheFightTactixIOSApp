//
//  IOGrowHeader.swift
//  FightTactix
//
//  Created by Andrew Nero on 12/23/15.
//  Copyright © 2015 Andrew Nero. All rights reserved.
//

import UIKit
import IOStickyHeader

class IOGrowHeader: UICollectionViewCell {
    
    @IBOutlet weak var imgPhoto: UIImageView!
    @IBOutlet weak var btnBot: UIButton!
    @IBOutlet weak var constraintImgSize: NSLayoutConstraint!
    
    override func awakeFromNib() {
        self.imgPhoto.layer.cornerRadius = self.imgPhoto.frame.size.width * 0.5
        //self.btnBot.layer.cornerRadius = 5
    }
    
    override func applyLayoutAttributes(layoutAttributes: UICollectionViewLayoutAttributes) {
        guard let layoutAttributes:IOStickyHeaderFlowLayoutAttributes = layoutAttributes as? IOStickyHeaderFlowLayoutAttributes else { return }
        
        if layoutAttributes.progressiveness < 1 {
            self.constraintImgSize.constant = 100
            self.imgPhoto.updateConstraintsIfNeeded()
        } else {
            self.constraintImgSize.constant = 130 * layoutAttributes.progressiveness
            self.imgPhoto.updateConstraintsIfNeeded()
        }
    }
    
}
