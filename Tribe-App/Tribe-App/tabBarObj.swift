//
//  tabBarObj.swift
//  Tribe-App
//
//  Created by Charlie Martell on 7/25/14.
//  Copyright (c) 2014 TheTribe. All rights reserved.
//

import UIKit

class tabBarObj: UITabBar {
    
    init() {
        let frame =  CGRectMake(0, 0, 320, 50)
        super.init(frame: frame)
        self.setupTabBar()
        // Initialization code
    }
    
    func setupTabBar() {
        //let tabItems = self.items as [UITabBarItem]
        self.items = [tabBarItem0 as UITabBarItem, tabBarItem1 as UITabBarItem, tabBarItem2 as UITabBarItem, tabBarItem3 as UITabBarItem, tabBarItem4 as UITabBarItem]
        
        //setup tabBarItem Titles
        tabBarItem0.title = "Money"
        tabBarItem1.title = "Event"
        tabBarItem2.title = "Messages"
        tabBarItem3.title = "Chill"
        tabBarItem4.title = "Settings"
        
        //setup tabBarItem Tags
        tabBarItem0.tag = 0
        tabBarItem1.tag = 1
        tabBarItem2.tag = 2
        tabBarItem3.tag = 3
        tabBarItem4.tag = 4
    }

}
