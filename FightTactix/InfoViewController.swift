//
//  InfoViewController.swift
//  FightTactix
//
//  Created by Andrew Nero on 12/7/15.
//  Copyright © 2015 Andrew Nero. All rights reserved.
//

import UIKit

class InfoViewController: UIViewController {
    
    
    
    @IBOutlet weak var phoneNumber: UIButton!
    @IBOutlet weak var emailAddress: UIButton!
    @IBOutlet weak var seeMap: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        phoneNumber.addTarget(self, action: "call:", forControlEvents: .TouchUpInside)
        emailAddress.addTarget(self, action: "mail:", forControlEvents: .TouchUpInside)
        seeMap.addTarget(self, action: "map:", forControlEvents: .TouchUpInside)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func call(sender: UIButton) {
        
        UIApplication.sharedApplication().openURL(NSURL(string: "tel://2033075728")!)
        
    }
    
    func mail(sender: UIButton) {
        
        UIApplication.sharedApplication().openURL(NSURL(string: "mailto://fighttactix@gmail.com")!)
        
    }
    
    
    func map(sender: UIButton) {
        
        UIApplication.sharedApplication().openURL(NSURL(string: "https://goo.gl/maps/dFwSBKUoNpA2")!)
        
    }

}
