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
    
    
    static func currentSchedule() {
        
        let params = [String: String]()
    
        PFCloud.callFunctionInBackground("currentSchedule", withParameters: params) {
            result, error in
            if( error === nil) {
                NSLog("currentSch: \(result) ")
                self.vcurrentSchedule = result as! [Meeting]
            }
            else if (error != nil) {
                NSLog("error")
            }
        }
    }
    
    static func userClassHistory() {
        
        let params = [String: String]()
        
        PFCloud.callFunctionInBackground("userClassHistory", withParameters: params) {
            result, error in
            if ( error === nil) {
                NSLog("userClassHist: \(result) ")
                self.vuserClassHistory = result as! [Attendance]
            }
            else if (error != nil) {
                NSLog("error")
            }
        }}
}
