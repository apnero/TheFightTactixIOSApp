//
//  HistoryViewController.swift
//  FightTactix
//
//  Created by Andrew Nero on 12/10/15.
//  Copyright © 2015 Andrew Nero. All rights reserved.
//

import UIKit
import SwiftMoment
import Parse

class HistoryCell2 : UITableViewCell {
    
    
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





class HistoryViewController: UITableViewController {
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.tableHeaderView = UIView()
        
    }
    
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return CloudQueries.vuserClassHistory.count
    }
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("historyCell", forIndexPath: indexPath) as! HistoryCell2
        
        cell.set(indexPath.row)
        
        
        return cell
    }
    
    
}