//
//  ScheduleViewController.swift
//  FightTactix
//
//  Created by Andrew Nero on 12/3/15.
//  Copyright © 2015 Andrew Nero. All rights reserved.
//

import UIKit
import SwiftMoment
import Parse

class MeetingCell : UITableViewCell {
    
    @IBOutlet weak var date: UILabel!
    @IBOutlet weak var time: UILabel!
    @IBOutlet weak var status: UILabel!
    
    
    func set(row: Int) {
        let meeting = CloudQueries.vcurrentSchedule[row]
        
        let classDate = meeting.date!
        let endTime = moment(classDate) + 2.hours
        date.text = moment(classDate).format("EEE, MMM d")
        time.text = moment(classDate).format("hh:mm aaa") + "-" + endTime.format("hh:mm aaa")
        
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
        
        
        if checkedin {
            status?.text = "Checked-In"
            status?.textColor = UIColor.magentaColor()
        } else if registered {
            if (moment() + 4.hours > moment(classDate) ) {
                status?.text = "Registered (< 4 hours)"
                status?.textColor = UIColor.blueColor()
            } else {
                status?.text = "Registered"
                status?.textColor = UIColor.blueColor()}
        } else if soldOut {
            status?.text = "MAX Registered"
            status?.textColor = UIColor.redColor()
        } else if (meeting.open!) {
            status?.text = "Register"
        } else { status?.text = "Registration Closed"}
        
        
    }
    
}





class ScheduleViewController: UITableViewController {
    
   
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.tableHeaderView = UIView()
        
    }
    
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return CloudQueries.vcurrentSchedule.count
    }
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("meetingCell", forIndexPath: indexPath) as! MeetingCell
   
        cell.set(indexPath.row)
        
        return cell
    }
    
    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        
        let cell = tableView.cellForRowAtIndexPath(indexPath) as! MeetingCell
    
        var params = [String:NSDate]()
        params["date"] = CloudQueries.vcurrentSchedule[indexPath.row].date
        
        if cell.status.text == "Register" {
            CloudCalls.registerForClass(params)
            cell.status.text  = "Registered"
            cell.status.textColor = UIColor.blueColor()
        }
        else if cell.status.text == "Registered" {
            CloudCalls.unRegisterForClass(params)
            cell.status.text = "Register"
            cell.status.textColor = UIColor.blackColor()
        }
    }
    
    
}

