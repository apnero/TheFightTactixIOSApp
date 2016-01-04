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
        Parse.enableLocalDatastore()
        Parse.setApplicationId(valueForAPIId("API_CLIENT_ID"), clientKey: valueForAPIKey("API_CLIENT_KEY"))
        PFFacebookUtils.initializeFacebookWithApplicationLaunchOptions(launchOptions)
        
        Meeting.registerSubclass()
        Attendance.registerSubclass()
        Cards.registerSubclass()
        Notifications.registerSubclass()
        
        let types: UIUserNotificationType = [ UIUserNotificationType.Badge, UIUserNotificationType.Alert, UIUserNotificationType.Sound]
        
        let settings: UIUserNotificationSettings = UIUserNotificationSettings(forTypes: types, categories: nil)
        
        application.registerUserNotificationSettings(settings)
        application.registerForRemoteNotifications()
        
        return true
    }
    
    func application(application: UIApplication, openURL url: NSURL, sourceApplication: String?, annotation: AnyObject) -> Bool {
        return FBSDKApplicationDelegate.sharedInstance().application(application, openURL: url, sourceApplication: sourceApplication, annotation: annotation)
    }
    
    func applicationDidBecomeActive(application: UIApplication) {
        FBSDKAppEvents.activateApp()
    }
    
    func application(application: UIApplication, didRegisterForRemoteNotificationsWithDeviceToken deviceToken: NSData) {
        print("didRegisterForRemoteNotificationsWithDeviceToken")
        
        let currentInstallation = PFInstallation.currentInstallation()
        
        currentInstallation.setDeviceTokenFromData(deviceToken)
        currentInstallation.saveInBackgroundWithBlock { (succeeded, e) -> Void in
            if (e == nil){
                print ("installation saved with token")
            }
            else {print ("installation saving with token failed")}
        }
    }
    
    func application(application: UIApplication, didFailToRegisterForRemoteNotificationsWithError error: NSError) {
        print("failed to register for remote notifications:  (error)")
        let currentInstallation = PFInstallation.currentInstallation()
        currentInstallation.saveInBackgroundWithBlock { (succeeded, e) -> Void in
            if (e == nil){
                print ("installation saved")
            }
            else {print ("installation saving failed")}
        }
    }
    
    func application(application: UIApplication, didReceiveRemoteNotification userInfo: [NSObject : AnyObject]) {
        print("didReceiveRemoteNotification")
        PFPush.handlePush(userInfo)
    }
}





