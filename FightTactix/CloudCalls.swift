//
//  CloudCalls.swift
//  FightTactix
//
//  Created by Andrew Nero on 12/10/15.
//  Copyright © 2015 Andrew Nero. All rights reserved.
//

import Foundation
import Parse


class CloudCalls {
    
    
    static func registerForClass(params: [String: NSDate]) {
        
        PFCloud.callFunctionInBackground("registerForClass", withParameters: params) {
            result, error in
            if( error === nil) {
            
            }
            else if (error != nil) {
                NSLog("error")
            }
        }
    }
    
    static func unRegisterForClass(params: [String: NSDate]) {
        
        PFCloud.callFunctionInBackground("unRegisterForClass", withParameters: params) {
            result, error in
            if( error === nil) {
                
            }
            else if (error != nil) {
                NSLog("error")
            }
        }
    }
    
    
}
