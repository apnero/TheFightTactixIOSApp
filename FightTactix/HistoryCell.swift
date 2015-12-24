//
//  HistoryCell.swift
//  FightTactix
//
//  Created by Andrew Nero on 12/23/15.
//  Copyright © 2015 Andrew Nero. All rights reserved.
//

import SwiftMoment

class HistoryCell : UICollectionViewCell {
    
    @IBOutlet weak var date: UILabel!
    @IBOutlet weak var time: UILabel!
    @IBOutlet weak var status: UILabel!
    
    func set(row: Int) {
        let attendance = CloudQueries.vuserClassHistory[row]
        
        let classDate = attendance.date!
        let endTime = moment(classDate) + 2.hours
        date.text = moment(classDate).format("EEE, MMM d")
        time.text = moment(classDate).format("hh:mm aaa") + "-" + endTime.format("hh:mm aaa")
        
        
        if moment(attendance.date!) < moment() {
            status?.text = "Complete"
            status?.backgroundColor = UIColor.blackColor()
        }
        else if attendance.checkedin == true {
            status?.text = "Checked-In"
            status?.backgroundColor = UIColor.magentaColor()
        }
        else {
            status?.text = "Registered"
        }
    }
    
}

