//
//  MessageModel.swift
//  FightTactix
//
//  Created by Andrew Nero on 12/24/15.
//  Copyright © 2015 Andrew Nero. All rights reserved.
//

import Foundation
import Parse

class Notifications : PFObject, PFSubclassing {
    
    var text: String? {
        get {
            return self["text"] as? String
        }
        set {
            self["text"] = newValue
        }
    }
    

    
    class func parseClassName() -> String {
        return "Notifications"
    }
}