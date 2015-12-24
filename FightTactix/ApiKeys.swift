//
//  ApiKeys.swift
//  FightTactix
//
//  Created by Andrew Nero on 12/21/15.
//  Copyright © 2015 Andrew Nero. All rights reserved.
//

import Foundation

func valueForAPIId(keyname:String) -> String {
    let filePath = NSBundle.mainBundle().pathForResource("ApiKeys", ofType: "plist")
    let plist = NSDictionary(contentsOfFile: filePath!)
    
    let value:String = plist?.objectForKey(keyname) as! String

    return value

}


func valueForAPIKey(keyname:String) -> String {
    let filePath = NSBundle.mainBundle().pathForResource("ApiKeys", ofType: "plist")
    let plist = NSDictionary(contentsOfFile: filePath!)
    
    let value:String = plist?.objectForKey(keyname) as! String
    
    return value
    
}