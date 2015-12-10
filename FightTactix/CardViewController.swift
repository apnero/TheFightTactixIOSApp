//
//  CardViewController.swift
//  FightTactix
//
//  Created by Andrew Nero on 12/9/15.
//  Copyright © 2015 Andrew Nero. All rights reserved.
//

import UIKit

class CardViewController: UITableViewController {
    
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return CloudQueries.vuserPunchCards.count
    }
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("CardCell", forIndexPath: indexPath)
        let card = CloudQueries.vuserPunchCards[indexPath.row]
        
        
        
        return cell
    }
    
    
}
