//
//  CardViewController.swift
//  FightTactix
//
//  Created by Andrew Nero on 12/9/15.
//  Copyright © 2015 Andrew Nero. All rights reserved.
//

import UIKit
import SwiftMoment
import Parse

class CardCell : UITableViewCell {
    
    @IBOutlet weak var date: UILabel!
    @IBOutlet weak var credits: UILabel!
    
    func set(row: Int) {
        let card = CloudQueries.vuserPunchCards[row]
        
        let cardDate = card.date!
        date.text = moment(cardDate).format("EEE, MMM d")
        credits.text = "\(card.credits!)"
        //credits.backgroundColor = UIColor.blueColor()
        //credits.textColor = UIColor.whiteColor()
        //credits.layer.cornerRadius = 5
        credits.clipsToBounds = true
    }
    
}





class CardViewController: UITableViewController {
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.tableHeaderView = UIView()
        
    }
    
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return CloudQueries.vuserPunchCards.count
    }
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("cardCell", forIndexPath: indexPath) as! CardCell
        
        cell.set(indexPath.row)
        
        
        return cell
    }
    
    
}
