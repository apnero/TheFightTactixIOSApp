//
//  MeetingCell.swift
//  FightTactix
//
//  Created by Andrew Nero on 12/23/15.
//  Copyright © 2015 Andrew Nero. All rights reserved.
//

import SwiftMoment
import LTMorphingLabel


class MeetingCell : UICollectionViewCell {
    
    @IBOutlet weak var date: UILabel!
    @IBOutlet weak var time: UILabel!
    @IBOutlet weak var status: LTMorphingLabel!
    @IBOutlet weak var location: UILabel!
    
    
    func set(row: Int) {
  
        
        
        let meeting = CloudQueries.vcurrentSchedule[row]
        
        let classDate = meeting.date!
        let endTime = moment(classDate) + 2.hours
        date.text = moment(classDate).format("EEE, MMM d")
        time.text = moment(classDate).format("hh:mm aaa") + "-" + endTime.format("hh:mm aaa")
        location.text = meeting.location!
        
        var soldOut = false
        var registered = false
        var checkedin = false
        for attendance in CloudQueries.vuserClassHistory {
            if attendance.date == classDate {
                if attendance.checkedin == true {
                    checkedin = true
                }
                else { registered = true}
            }
        }
        
        for session in CloudQueries.vcurrentEnrolled {
            if meeting.objectId == session.meetingId {
                if session.number >= CloudQueries.vmaxClassSize {
                    soldOut = true
                }
            }
        }
        
        
        status.morphingEffect = LTMorphingEffect.Pixelate
        
        if checkedin {
            status?.text = "Checked-In"
            status?.textColor = UIColor.magentaColor()
        } else if registered {
            if (moment() + 1.hours > moment(classDate) ) {
                status?.text = "Registered(<1 hour)"
                status?.textColor = UIColor.blueColor()
            } else {
                status?.text = "Registered"
                status?.textColor = UIColor.blueColor()}
        } else if soldOut {
            status?.text = "MAX Registered"
            status?.textColor = UIColor.redColor()
        } else if (meeting.open!) {
            status?.text = "Register"
            status?.textColor = UIColor.blackColor()
        } else { status?.text = "Registration Closed"
            status?.textColor = UIColor.grayColor()
        }
        
        
    }
    
}