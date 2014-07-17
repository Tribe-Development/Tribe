//
//  vcController.swift
//  Tribe-App
//
//  Created by Charlie Martell on 7/16/14.
//  Copyright (c) 2014 TheTribe. All rights reserved.
//

import UIKit

class vcMessagesLeft: UIViewController {
    
    func setupNavigation(){
        
        //Money Button
        let moneyButton : UIButton = UIButton.buttonWithType(UIButtonType.Custom) as UIButton
        moneyButton.frame = CGRectMake(0, 509, 64, 59)
        moneyButton.backgroundColor = UIColorFromRGB(0x33CC99)
        moneyButton.addTarget(self, action: Selector("toMoney"), forControlEvents: UIControlEvents.TouchUpInside)
        moneyButton.setTitle("Money", forState: UIControlState.Normal)
        self.view.addSubview(moneyButton)
        
        //Event Button
        let eventButton : UIButton = UIButton.buttonWithType(UIButtonType.Custom) as UIButton
        eventButton.frame = CGRectMake(64, 509, 64, 59)
        eventButton.backgroundColor = UIColorFromRGB(0x33CC99)
        eventButton.addTarget(self, action: Selector("toEvent"), forControlEvents: UIControlEvents.TouchUpInside)
        eventButton.setTitle("Event", forState: UIControlState.Normal)
        self.view.addSubview(eventButton)
        
        //Message Button
        let messageButton : UIButton = UIButton.buttonWithType(UIButtonType.Custom) as UIButton
        messageButton.frame = CGRectMake(128, 509, 64, 59)
        messageButton.backgroundColor = UIColorFromRGB(0x33CC4D)
        messageButton.addTarget(self, action: Selector("doNothing"), forControlEvents: UIControlEvents.TouchUpInside)
        messageButton.setTitle("Messge", forState: UIControlState.Normal)
        self.view.addSubview(messageButton)
        
        //Chill Button
        let chillButton : UIButton = UIButton.buttonWithType(UIButtonType.Custom) as UIButton
        chillButton.frame = CGRectMake(192, 509, 64, 59)
        chillButton.backgroundColor = UIColorFromRGB(0x33CC99)
        chillButton.addTarget(self, action: Selector("toChill"), forControlEvents: UIControlEvents.TouchUpInside)
        chillButton.setTitle("Chill", forState: UIControlState.Normal)
        self.view.addSubview(chillButton)
        
        //Settings Button
        let settingsButton : UIButton = UIButton.buttonWithType(UIButtonType.Custom) as UIButton
        settingsButton.frame = CGRectMake(256, 509, 64, 59)
        settingsButton.backgroundColor = UIColorFromRGB(0x33CC99)
        settingsButton.addTarget(self, action: Selector("toSettings"), forControlEvents: UIControlEvents.TouchUpInside)
        settingsButton.setTitle("Set's", forState: UIControlState.Normal)
        self.view.addSubview(settingsButton)
    }
    
    //Lets you pass a hexadecimal value and make a UIColor object from it
    func UIColorFromRGB(rgbValue: UInt) -> UIColor {
        return UIColor(
            red: CGFloat((rgbValue & 0xFF0000) >> 16) / 255.0,
            green: CGFloat((rgbValue & 0x00FF00) >> 8) / 255.0,
            blue: CGFloat(rgbValue & 0x0000FF) / 255.0,
            alpha: CGFloat(1.0)
        )
    }
    
    func notImplemented() {
        var loginAlert:UIAlertController = UIAlertController(title: "Not Implemented", message: "This Feature is Coming Soon!", preferredStyle: UIAlertControllerStyle.Alert)
        self.presentViewController(loginAlert, animated: true, completion: nil)
    }
    
    func doNothing() {
        //Does Nothing!
    }
    
    func toChill(){
        performSegueWithIdentifier("messageLeftToChill", sender: self)
    }
    
    func toSettings(){
        performSegueWithIdentifier("messageLeftToSettings", sender: self)
    }
    
    func toMoney(){
        performSegueWithIdentifier("messageLeftToMoney", sender: self)
    }
    
    func toEvent(){
        performSegueWithIdentifier("messageLeftToEvent", sender: self)
    }
    
    func setupSwipeGestures() {
        var swipeLeft = UISwipeGestureRecognizer(target: self, action: "respondToSwipeGesture:")
        swipeLeft.direction = UISwipeGestureRecognizerDirection.Left
        self.view.addGestureRecognizer(swipeLeft)
    }
    
    func respondToSwipeGesture(gesture: UIGestureRecognizer) {
        
        if let swipeGesture = gesture as? UISwipeGestureRecognizer {
            
            switch swipeGesture.direction {
            case UISwipeGestureRecognizerDirection.Left:
                performSegueWithIdentifier("messageLeftToMessage", sender: self)
            default:
                break
            }
        }
    }
    
    override func viewDidLoad() {
        setupSwipeGestures()
        var label = UILabel(frame: CGRectMake(0, 0, 200, 21))
        label.center = CGPointMake(160, 284)
        label.textAlignment = NSTextAlignment.Center
        label.text = "Messages Left"
        self.view.addSubview(label)
        setupNavigation()
        // Do any additional setup after loading the view.
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
}
