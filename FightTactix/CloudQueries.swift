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
    static var loading = 3
    
    
    static func currentSchedule(controller: MainScreenController) {
        
        let params = [String: String]()
    
        PFCloud.callFunctionInBackground("currentSchedule", withParameters: params) {
            result, error in
            if( error === nil) {
                NSLog("currentSch: \(result) ")
                self.vcurrentSchedule = result as! [Meeting]
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
    
    static func userClassHistory(controller: MainScreenController) {
        
        let params = [String: String]()
        
        PFCloud.callFunctionInBackground("userClassHistory", withParameters: params) {
            result, error in
            if ( error === nil) {
                NSLog("userClassHist: \(result) ")
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
                NSLog("userPunchCards: \(result) ")
                self.vuserPunchCards = result as! [Cards]
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
    
}
