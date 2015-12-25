//
//  CardCell.swift
//  FightTactix
//
//  Created by Andrew Nero on 12/24/15.
//  Copyright © 2015 Andrew Nero. All rights reserved.
//

import SwiftMoment

class CardCell  : UICollectionViewCell {
    
    
    @IBOutlet weak var date: UILabel!
    @IBOutlet weak var credits: UILabel!
    
    
    func set(row: Int) {
        let card = CloudQueries.vuserPunchCards[row]
        
        let cardDate = card.date!
        date.text = moment(cardDate).format("EEE, MMM d")
        credits.text = "\(card.credits!)"
        credits.backgroundColor = UIColor.blackColor()
        credits.clipsToBounds = true
    }
    
}

