//
//  CardsModel.swift
//  FightTactix
//
//  Created by Andrew Nero on 12/4/15.
//  Copyright © 2015 Andrew Nero. All rights reserved.
//

import Foundation
import Parse

class Cards : PFObject, PFSubclassing {
    
    var username: String? {
        get {
            return self["username"] as? String
        }
        set {
            self["username"] = newValue
        }
    }
    
    var credits: Int? {
        get {
            return self["credits"] as? Int
        }
        set {
            self["credits"] = newValue
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
    

    
    class func parseClassName() -> String {
        return "Cards"
    }
}