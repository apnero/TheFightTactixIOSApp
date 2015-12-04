//
//  TestViewController.swift
//  FightTactix
//
//  Created by Andrew Nero on 12/2/15.
//  Copyright © 2015 Andrew Nero. All rights reserved.
//

import UIKit
import ENSwiftSideMenu

class MainScreenController: UIViewController, ENSideMenuDelegate {
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.sideMenuController()?.sideMenu?.delegate = self
        self.tabBarController?.navigationItem.title = "Fight Tactix"
        self.tabBarController?.navigationItem.setLeftBarButtonItem(UIBarButtonItem(title: "Menu", style: .Plain, target: self, action: "toggleSideMenu:"), animated: true)
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
   func toggleSideMenu(sender: UIBarButtonItem) {
        toggleSideMenuView()
    }
    
    // MARK: - ENSideMenu Delegate
    func sideMenuWillOpen() {
        print("sideMenuWillOpen")
    }
    
    func sideMenuWillClose() {
        print("sideMenuWillClose")
    }
    
    func sideMenuShouldOpenSideMenu() -> Bool {
        print("sideMenuShouldOpenSideMenu")
        return true
    }
    
    func sideMenuDidClose() {
        print("sideMenuDidClose")
    }
    
    func sideMenuDidOpen() {
        print("sideMenuDidOpen")
    }
}

