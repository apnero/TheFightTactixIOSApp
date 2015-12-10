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
        
        if checkedin {
            status?.text = "CHECKED IN"
        } else if registered {
            if (moment() + 4.hours > moment(classDate) ) {
                status?.text = "Registered (< 4 hours)"
            } else { status?.text = "Registered"}
        } else if soldOut {
            status?.text = "MAX Registered"
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
    

}

