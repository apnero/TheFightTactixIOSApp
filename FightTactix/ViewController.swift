//
//  ViewController.swift
//  FightTactix
//
//  Created by Andrew Nero on 12/1/15.
//  Copyright © 2015 Andrew Nero. All rights reserved.
//


import UIKit
import ParseUI
import ParseFacebookUtilsV4
import SwiftyJSON
import EZLoadingActivity

class ViewController: UIViewController, PFLogInViewControllerDelegate, PFSignUpViewControllerDelegate {
    
    override func viewDidAppear(animated: Bool) {
        super.viewDidAppear(animated)
        if (PFUser.currentUser() == nil) {
            let loginViewController = PFLogInViewController()
            loginViewController.delegate = self
            loginViewController.fields = [.UsernameAndPassword, .LogInButton, .PasswordForgotten, .SignUpButton, .Facebook]
            loginViewController.emailAsUsername = true
            
            let signUpViewController = PFSignUpViewController()
            signUpViewController.delegate = self
            signUpViewController.fields = [ .Additional, .Email, .SignUpButton, .DismissButton]
            signUpViewController.emailAsUsername = true
            signUpViewController.signUpView?.additionalField?.placeholder = "Name"
            let logoImage = UIImageView()
            logoImage.image = UIImage(named: "tactix_name")
            logoImage.contentMode = UIViewContentMode.ScaleAspectFit
            loginViewController.logInView?.logo = logoImage
            logoImage.contentMode = UIViewContentMode.ScaleAspectFill
            signUpViewController.signUpView?.logo = logoImage
            loginViewController.logInView?.backgroundColor = UIColor.blackColor()
            signUpViewController.signUpView?.backgroundColor = UIColor.blackColor()
            
            loginViewController.signUpController = signUpViewController
            
            self.presentViewController(loginViewController, animated: false, completion: nil)
        } else {
            presentMainMenu()
        }
    }
    
    func logInViewController(logInController: PFLogInViewController, didLogInUser user: PFUser) {
        self.dismissViewControllerAnimated(true, completion: nil)
        //presentMainMenu()
    }
    
    func signUpViewController(signUpController: PFSignUpViewController, didSignUpUser user: PFUser) {
        self.dismissViewControllerAnimated(true, completion: nil)
        
        let name = signUpController.signUpView?.additionalField?.text
        let nameForChannel = name!.componentsSeparatedByString(" ").joinWithSeparator("")
        
        PFUser.currentUser()?.setObject(name!, forKey: "name")
        PFUser.currentUser()?.saveInBackground()
 
        
        if PFInstallation.currentInstallation().deviceToken != nil {
        
            let subscribedChannels:Array<String>? = PFInstallation.currentInstallation().channels
            if subscribedChannels == nil {
                PFPush.subscribeToChannelInBackground("All")
                if name != nil {
                    PFPush.subscribeToChannelInBackground(nameForChannel)
                }
            } else if !subscribedChannels!.contains("All") {
                PFPush.subscribeToChannelInBackground("All")
            } else if name != nil && !subscribedChannels!.contains(nameForChannel) {
                PFPush.subscribeToChannelInBackground(nameForChannel)
            }
        }

        
        presentMainMenu()
    }
    
    func makeGraphRequest() {
        
        let graphRequest : FBSDKGraphRequest = FBSDKGraphRequest(graphPath: "me", parameters: [ "fields" : "email, name, gender" ])
        graphRequest.startWithCompletionHandler({ (connection, result, error) -> Void in
            if error != nil {
                print("Error: \(error)")
            }
            else {
                var dic = [String:String]()
                
                if result.valueForKey("id") != nil {
                    dic["facebookId"] = result.valueForKey("id") as! String?
                }
                
                if result.valueForKey("name") != nil {
                    PFUser.currentUser()?.setObject(result.valueForKey("name") as! String!, forKey: "name")
                    dic["name"] = result.valueForKey("name") as! String?
                }
                
                if result.valueForKey("email") != nil {
                    PFUser.currentUser()?.setObject(result.valueForKey("email") as! String!, forKey:  "email")
                    dic["email"] = result.valueForKey("email") as! String?
                }
                
                
                let userProfile:JSON = JSON(dic)
                
                PFUser.currentUser()?.setObject(userProfile.rawValue, forKey: "profile")
                PFUser.currentUser()?.saveInBackground()
                print("Result: \(result)")
            }
            
            
        })
        
    }
    
    func presentMainMenu() {
        
        
        EZLoadingActivity.show("Loading...", disableUI: true)
        
        
        CloudQueries.currentSchedule(self)
        CloudQueries.userClassHistory(self)
        CloudQueries.userPunchCards(self)
        CloudQueries.notifications(self)
        
        
        if PFFacebookUtils.isLinkedWithUser(PFUser.currentUser()!) && PFUser.currentUser()?.objectForKey("profile") == nil {
            makeGraphRequest()
        }
        
        
    }
    
    func loaded() {
        EZLoadingActivity.hide(success: true, animated: true)
        
        let mainStoryboard: UIStoryboard = UIStoryboard(name: "Main",bundle: nil)
        let destViewController : UIViewController = mainStoryboard.instantiateViewControllerWithIdentifier("MainViewController")
        self.presentViewController(destViewController, animated: true, completion: nil)
        
        
        
    }
}