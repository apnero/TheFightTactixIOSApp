//
//  AppDelegate.swift
//  FightTactix
//
//  Created by Andrew Nero on 12/1/15.
//  Copyright © 2015 Andrew Nero. All rights reserved.
//

import UIKit
import Parse
import ParseFacebookUtilsV4


@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {
    
    var window: UIWindow?
    

    
    
    func application(application: UIApplication, didFinishLaunchingWithOptions launchOptions: [NSObject: AnyObject]?) -> Bool {
        Parse.setApplicationId("A7hkeyC96XycUj3dPqplGO5ltPYyu1PXT39O663R", clientKey:"ZsKBS95aegUHNght50r8INIiAro0Siyw6diLDXba")
        PFFacebookUtils.initializeFacebookWithApplicationLaunchOptions(launchOptions)
        
        Meeting.registerSubclass()
        Attendance.registerSubclass()
        
        CloudQueries.currentSchedule()
        CloudQueries.userClassHistory()
        
        return true
    }
    
    func application(application: UIApplication, openURL url: NSURL, sourceApplication: String?, annotation: AnyObject) -> Bool {
        return FBSDKApplicationDelegate.sharedInstance().application(application, openURL: url, sourceApplication: sourceApplication, annotation: annotation)
    }
    
    func applicationDidBecomeActive(application: UIApplication) {
        FBSDKAppEvents.activateApp()
    }
    
}





