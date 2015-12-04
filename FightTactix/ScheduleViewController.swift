//
//  ScheduleViewController.swift
//  FightTactix
//
//  Created by Andrew Nero on 12/3/15.
//  Copyright © 2015 Andrew Nero. All rights reserved.
//

import UIKit
import ENSwiftSideMenu
import SwiftMoment
import Parse

class ScheduleViewController: UITableViewController, ENSideMenuDelegate {
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.sideMenuController()?.sideMenu?.delegate = self
        self.tabBarController?.navigationItem.title = "Schedule"
        //self.tabBarController?.navigationItem.setLeftBarButtonItem(UIBarButtonItem(title: "Menu", style: .Plain, target: self, action: "toggleSideMenu:"), animated: true)

        
    }
    
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return CloudQueries.vcurrentSchedule.count
    }
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("MeetingCell", forIndexPath: indexPath)
        let meeting = CloudQueries.vcurrentSchedule[indexPath.row]
        
        let classDate = meeting.date!
        let endTime = moment(classDate) + 2.hours
        cell.textLabel?.text = moment(classDate).format("EEE, MMM d") + "\n" + moment(classDate).format("hh:mm aaa") + "-" + endTime.format("hh:mm aaa")
        
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
            cell.detailTextLabel?.text = "CHECKED IN"
        } else if registered {
            if (moment() + 4.hours > moment(classDate) ) {
                cell.detailTextLabel?.text = "Registered (< 4 hours)"
            } else { cell.detailTextLabel?.text = "Registered"}
        } else if soldOut {
            cell.detailTextLabel?.text = "MAX Registered"
        } else if (meeting.open!) {
            cell.detailTextLabel?.text = "Register"
        } else { cell.detailTextLabel?.text = "Registration Closed"}
        
       
        
        return cell
    }
    
    func toggleSideMenu(sender: UIBarButtonItem) {
        toggleSideMenuView()
    }
}

