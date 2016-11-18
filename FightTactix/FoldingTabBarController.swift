//
//  FoldingTabBarController.swift
//  FightTactix
//
//  Created by Andrew Nero on 12/23/15.
//  Copyright © 2015 Andrew Nero. All rights reserved.
//

import UIKit
import FoldingTabBar

class FoldingTabBarController: YALFoldingTabBarController, YALTabBarInteracting {

    let tabItem1: YALTabBarItem = YALTabBarItem(itemImage: UIImage(named: "wall clock-3"), leftItemImage:UIImage(named: "sms1"), rightItemImage:UIImage(named: "sms1"))
    let tabItem2: YALTabBarItem = YALTabBarItem(itemImage: UIImage(named: "social11"), leftItemImage:UIImage(named: "sms1"), rightItemImage:UIImage(named: "sms1"))
    
    let tabItem3: YALTabBarItem = YALTabBarItem(itemImage: UIImage(named: "professor8"), leftItemImage:UIImage(named: "sms1"), rightItemImage:UIImage(named: "sms1"))
    let tabItem4: YALTabBarItem = YALTabBarItem(itemImage: UIImage(named: "credit card3"), leftItemImage:UIImage(named: "sms1"), rightItemImage:UIImage(named: "sms1"))
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        super.leftBarItems = [tabItem1, tabItem2]
        super.rightBarItems = [tabItem3, tabItem4]
        super.centerButtonImage = UIImage(named: "iostabbar-2")
        
        tabBarView.extraTabBarItemHeight = YALExtraTabBarItemsDefaultHeight
        tabBarView.offsetForExtraTabBarItems = YALForExtraTabBarItemsDefaultOffset
        tabBarView.backgroundColor =  UIColor.blackColor()
        tabBarView.tabBarColor = UIColor.whiteColor()
        tabBarView.dotColor = UIColor.blueColor()
        tabBarViewHeight = 65
        tabBarView.tabBarViewEdgeInsets = YALTabBarViewHDefaultEdgeInsets
        tabBarView.tabBarItemsEdgeInsets = YALTabBarViewItemsDefaultEdgeInsets
    }
    


}
