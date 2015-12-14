//
//  CloudQueries.swift
//  FightTactix
//
//  Created by Andrew Nero on 12/3/15.
//  Copyright © 2015 Andrew Nero. All rights reserved.
//

import Foundation
import Parse


class CloudQueries {
    
    static var vcurrentSchedule = [Meeting]()
    static var vuserClassHistory = [Attendance]()
    static var vuserPunchCards = [Cards]()
    static var vmaxClassSize = 99
    static var vcurrentEnrolled = [CurrentAttendance]()
    static var loading = 3
    
    
    static func currentSchedule(controller: MainScreenController) {
        
        maxClassSize()
        
        let params = [String: String]()
    
        PFCloud.callFunctionInBackground("currentSchedule", withParameters: params) {
            result, error in
            if( error === nil) {
                //NSLog("currentSch: \(result) ")
                self.vcurrentSchedule = result as! [Meeting]
                
                for meeting in self.vcurrentSchedule {
                   currentEnrolled(meeting.objectId!)
                }

                loading -= 1
                
                if loading == 0 {
                    controller.loaded()
                }
            }
            else if (error != nil) {
                NSLog("currentscherror")
            }
        }
    }
    
    static func currentEnrolled(objectId:String) {
        
        
        var params = [String: String]()
        params["objectId"] = objectId
        
        PFCloud.callFunctionInBackground("currentEnrolled", withParameters: params) {
            result, error in
            if( error === nil) {
                //NSLog("enrolled: \(result) ")
                self.vcurrentEnrolled.append(CurrentAttendance(meetingId : objectId, number:  result as? Int) )
                

            }
            else if (error != nil) {
                NSLog("enrolled error")
            }
        }
    }
    
    static func maxClassSize() {
        
        let params = [String: String]()
        
        PFCloud.callFunctionInBackground("maxClassSize", withParameters: params) {
            result, error in
            if ( error === nil) {
                //NSLog("maxclasssize: \(result) ")
                self.vmaxClassSize = result as! Int
    
            }
            else if (error != nil) {
                NSLog("error")
            }
        }
    }
    
    static func userClassHistory(controller: MainScreenController) {
        
        let params = [String: String]()
        
        PFCloud.callFunctionInBackground("userClassHistory", withParameters: params) {
            result, error in
            if ( error === nil) {
                //NSLog("userClassHist: \(result) ")
                self.vuserClassHistory = result as! [Attendance]
                loading -= 1
                
                if loading == 0 {
                    controller.loaded()
                }
            }
            else if (error != nil) {
                NSLog("error")
            }
        }
    }
    
    static func userPunchCards(controller: MainScreenController) {
        
        let params = [String: String]()
        
        PFCloud.callFunctionInBackground("userPunchCards", withParameters: params) {
            result, error in
            if ( error === nil) {
                //NSLog("userPunchCards: \(result) ")
                self.vuserPunchCards = result as! [Cards]
                loading -= 1
                
                if loading == 0 {
                    controller.loaded()
                }
            
            }
            else if (error != nil) {
                NSLog("userpunchcards error")
            }
        }
    }
    
}
