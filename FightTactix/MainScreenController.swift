//
//  TestViewController.swift
//  FightTactix
//
//  Created by Andrew Nero on 12/2/15.
//  Copyright © 2015 Andrew Nero. All rights reserved.
//

import UIKit
import EZLoadingActivity
import SwiftMoment
import MZTimerLabel

class MainScreenController: UIViewController, MZTimerLabelDelegate {
    
    
    @IBOutlet weak var textChris: UIButton!
    @IBOutlet weak var purchaseCard: UIButton!
    @IBOutlet weak var creditsRemaining: UILabel!
    @IBOutlet weak var creditsPurchased: UILabel!
    @IBOutlet weak var classesAttended: UILabel!
    @IBOutlet weak var date: UILabel!
    @IBOutlet weak var timer: UILabel!
    @IBOutlet weak var checkin: UIButton!
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
               
        textChris.addTarget(self, action: "text:", forControlEvents: .TouchUpInside)
        purchaseCard.addTarget(self, action: "purchase:", forControlEvents: .TouchUpInside)
 
        
    }
    
    override func viewWillAppear(animated: Bool) {
        
        EZLoadingActivity.show("Loading...", disableUI: true)
        
        CloudQueries.loading = 3
        CloudQueries.currentSchedule(self)
        CloudQueries.userClassHistory(self)
        CloudQueries.userPunchCards(self)
        
    }
    
    func loaded() {
        EZLoadingActivity.hide(success: true, animated: true)
        
        var sum = 0
        for card in CloudQueries.vuserPunchCards {
            sum += card.credits!
        }
        
        let remaining = sum - CloudQueries.vuserClassHistory.count
        
        classesAttended.text = "\(CloudQueries.vuserClassHistory.count)"
        creditsPurchased.text = "\(sum)"
        creditsRemaining.text = "\(remaining)"
        
        for session in CloudQueries.vuserClassHistory {
            if moment(session.date!) < moment()  {
                date.text = moment(session.date!).format("EEE, MMM d hh:mm aaa")
                let mycountdownTimer = MZTimerLabel(label: timer, andTimerType: MZTimerLabelTypeTimer)
                mycountdownTimer.setCountDownTime(30)
                mycountdownTimer.delegate = self
                mycountdownTimer.start()
                break
            }
            
        }
    }
    func timerLabel(timerLabel: MZTimerLabel!, countingTo time: NSTimeInterval, timertype timerType: MZTimerLabelType) {
        if time < 10 {
            timer.textColor = UIColor.redColor()
        }
    }

    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    func text(sender: UIButton) {
        
        UIApplication.sharedApplication().openURL(NSURL(string: "sms://2035454694")!)
        
    }
    
    func purchase(sender: UIButton) {
        
        UIApplication.sharedApplication().openURL(NSURL(string: "https://kravmagact.sites.zenplanner.com/sign-up-now.cfm")!)
        
    }
    
}

