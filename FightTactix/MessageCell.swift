//
//  MessageCell.swift
//  FightTactix
//
//  Created by Andrew Nero on 12/24/15.
//  Copyright © 2015 Andrew Nero. All rights reserved.
//

import SwiftMoment


class MessageCell : UICollectionViewCell {
    

    
    @IBOutlet weak var message: UILabel!
    @IBOutlet weak var date: UILabel!
    
    
    func set(row: Int) {
        
        
        let notification = CloudQueries.vNotifications[row]
        message.text = notification.text
        
        let messageDate = notification.createdAt
        date.text = moment(messageDate!).format("EEE, MMM, d hh:mm aaa")
        
        

        
        
    }
    
}