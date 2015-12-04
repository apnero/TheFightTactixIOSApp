//
//  ScheduleViewController.swift
//  FightTactix
//
//  Created by Andrew Nero on 12/3/15.
//  Copyright © 2015 Andrew Nero. All rights reserved.
//

import UIKit
import ENSwiftSideMenu
import Parse

class ScheduleViewController: UITableViewController, ENSideMenuDelegate {
    
    
    var currentSchedule = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.sideMenuController()?.sideMenu?.delegate = self
        //self.tabBarController?.navigationItem.title = "Fight Tactix"
        //self.tabBarController?.navigationItem.setLeftBarButtonItem(UIBarButtonItem(title: "Menu", style: .Plain, target: self, action: "toggleSideMenu:"), animated: true)
        
        currentSchedule = CloudQueries.vcurrentSchedule
        print(currentSchedule)
        
        
    }
    
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return currentSchedule.count
    }
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("MeetingCell", forIndexPath: indexPath)
        let a = currentSchedule[indexPath.row] as! PFObject
        
        let dateFormatter = NSDateFormatter()
        dateFormatter.dateFormat = "EEE, MMM d hh:mm aaa"
        cell.textLabel?.text = dateFormatter.stringFromDate(a.valueForKey("date") as! NSDate)
        return cell
    }
    
    func toggleSideMenu(sender: UIBarButtonItem) {
        toggleSideMenuView()
    }
}

