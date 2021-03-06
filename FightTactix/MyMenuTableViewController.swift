//
//  MyMenuTableViewController.swift
//  FightTactix
//
//  Created by Andrew Nero on 12/2/15.
//  Copyright © 2015 Andrew Nero. All rights reserved.
//

import UIKit
import ENSwiftSideMenu



class MyMenuTableViewController: UITableViewController {
    var selectedMenuItem : Int = 0
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Customize apperance of table view
        tableView.contentInset = UIEdgeInsetsMake(64.0, 0, 0, 0) //
        tableView.separatorStyle = .None
        tableView.backgroundColor = UIColor.clearColor()
        tableView.scrollsToTop = false
        
        tableView.registerClass(NavMenuViewCell.self, forCellReuseIdentifier: NSStringFromClass(NavMenuViewCell))
        
        // Preserve selection between presentations
        self.clearsSelectionOnViewWillAppear = false
        
        tableView.selectRowAtIndexPath(NSIndexPath(forRow: selectedMenuItem, inSection: 0), animated: false, scrollPosition: .Middle)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // MARK: - Table view data source
    
    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        // Return the number of sections.
        return 1
    }
    
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // Return the number of rows in the section.
        return 3
    }
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        
        let cell = tableView.dequeueReusableCellWithIdentifier( NSStringFromClass(NavMenuViewCell), forIndexPath: indexPath) as? NavMenuViewCell
        
 
        //var cell = tableView.dequeueReusableCellWithIdentifier("CELL") as MyTableViewCell
        
        //if (cell == nil) {
            //cell = UITableViewCell(style: UITableViewCellStyle.Default, reuseIdentifier: "CELL")
          //  cell!.backgroundColor = UIColor.clearColor()
            //cell!.textLabel?.textColor = UIColor.darkGrayColor()
            //let selectedBackgroundView = UIView(frame: CGRectMake(0, 0, cell!.frame.size.width, cell!.frame.size.height))
            //selectedBackgroundView.backgroundColor = UIColor.grayColor().colorWithAlphaComponent(0.2)
            //cell!.selectedBackgroundView = selectedBackgroundView
        //}
        
        if indexPath.row == 0 {
            cell!.menuLabel?.text = "Home"
        }
        else if indexPath.row == 1 {
            cell!.menuLabel?.text = "Credit History"
            print ("la")
            print(CloudQueries.vuserClassHistory.count)
            cell!.creditLabel?.text = "\(CloudQueries.vuserPunchCards.count)"
        }
        else {
            cell!.menuLabel?.text = "Class History"
            cell!.creditLabel?.text = "\(CloudQueries.vuserClassHistory.count)"
        }
        
        
        
        
        
        

        
        return cell!
    }
    
    override func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        return 50.0
    }
    
    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        
        print("did select row: \(indexPath.row)")
        
        if (indexPath.row == selectedMenuItem) {
            return
        }
        
        selectedMenuItem = indexPath.row
        
        //Present new view controller
        let mainStoryboard: UIStoryboard = UIStoryboard(name: "Main",bundle: nil)
        var destViewController : UIViewController
        switch (indexPath.row) {
        case 0:
            destViewController = mainStoryboard.instantiateViewControllerWithIdentifier("ViewController1")
            break
        case 1:
            destViewController = mainStoryboard.instantiateViewControllerWithIdentifier("CardHistory")
            break
        case 2:
            destViewController = mainStoryboard.instantiateViewControllerWithIdentifier("ViewController3")
            break
        default:
            destViewController = mainStoryboard.instantiateViewControllerWithIdentifier("ViewController4")
            break
        }
        
        sideMenuController()?.setContentViewController(destViewController)
    }
   
    
    
       
    
    
    /*
    // MARK: - Navigation
    
    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue!, sender: AnyObject!) {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
    }
    */
    
}
