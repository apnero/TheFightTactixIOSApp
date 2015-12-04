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
    
    static var vcurrentSchedule = []
    
   // func getCurrentSchedule() -> [PFObject] {
    
 //       return vcurrentSchedule
    
  //  }
    
    static func currentSchedule() {
        
        
        let params = [String: String]()
        
        PFCloud.callFunctionInBackground("currentSchedule", withParameters: params) {
            result, error in
            if( error === nil) {
                NSLog("Rates: \(result) ")
                self.vcurrentSchedule = result as! [PFObject]
            }
            else if (error != nil) {
                NSLog("error")
            }
            
            
        }
    }
}
