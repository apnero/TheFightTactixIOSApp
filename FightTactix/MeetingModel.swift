//
//  MeetingModel.swift
//  FightTactix
//
//  Created by Andrew Nero on 12/3/15.
//  Copyright © 2015 Andrew Nero. All rights reserved.
//

import Foundation
import Parse

class Meeting : PFObject, PFSubclassing {
    
    var location: String? {
        get {
            return self["location"] as? String
        }
        set {
            self["location"] = newValue
        }
    }
    
    var date: NSDate? {
        get {
            return self["date"] as? NSDate
        }
        set {
            self["date"] = newValue
        }
    }
    
    var open: BooleanLiteralType? {
        get {
            return self["open"] as? BooleanLiteralType
        }
        set {
            self["open"] = newValue
        }
    }
    
    
    class func parseClassName() -> String {
        return "Meeting"
    }
}