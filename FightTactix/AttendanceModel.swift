//
//  AttendanceModel.swift
//  FightTactix
//
//  Created by Andrew Nero on 12/4/15.
//  Copyright © 2015 Andrew Nero. All rights reserved.
//

import Foundation
import Parse

class Attendance : PFObject, PFSubclassing {
    
    var username: String? {
        get {
            return self["username"] as? String
        }
        set {
            self["username"] = newValue
        }
    }
    
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
    
    var checkedin: BooleanLiteralType? {
        get {
            return self["checkedin"] as? BooleanLiteralType
        }
        set {
            self["checkedin"] = newValue
        }
    }
    
    
    class func parseClassName() -> String {
        return "Attendance"
    }
}