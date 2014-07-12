//
//  vcMain.swift
//  Tribe-App
//
//  Created by Charlie Martell on 7/11/14.
//  Copyright (c) 2014 TheTribe. All rights reserved.
//

import UIKit
import CoreData


class vcMain: UIViewController {
    @IBOutlet var usernameField: UITextField
    @IBOutlet var passwordField: UITextField

    @IBOutlet var loginLabel: UILabel
    @IBAction func loginButton(sender: AnyObject)
    {
        if checkLogin(loginHTTPPost(usernameField.text,tempPassword: passwordField.text))
        {
            loginLabel.text = "Login Successful!"
            loginLabel.textColor = UIColor.greenColor()
        }
        else
        {
            loginLabel.text = "Login Failed!"
            loginLabel.textColor = UIColor.redColor()
        }
    }
    @IBAction func registerButton(sender: AnyObject)
    {
        if usernameField.text != nil && passwordField.text != nil //add in other boxes
        {
            if checkLogin(registerHTTPPost(usernameField.text, tempPassword: passwordField.text))
            {
                loginLabel.text = "Account Registered!"
                loginLabel.textColor = UIColor.greenColor()
            }
            else
            {
                loginLabel.text = "Invalid Username"
                loginLabel.textColor = UIColor.redColor()
            }
        }
        else
        {
            loginLabel.text = "Please enter credentials!"
            loginLabel.textColor = UIColor.redColor()
        }
    }
    override func viewDidLoad()
    {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning()
    {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func checkLogin(retCode: Int)-> Bool
    {
        if(retCode == -1)
        {
            return true
        }
        else if (retCode > 0)
        {
            return false
        }
        return false
    }
    
    func loginHTTPPost(tempUsername: String, tempPassword: String) -> Int
    {
        var request = NSMutableURLRequest(URL: NSURL(string: "http://54.191.143.176:4567/login"))
        var session = NSURLSession.sharedSession()
        request.HTTPMethod = "POST"
        var paramString = "&username=" + tempUsername + "&password=" + tempPassword
        let dataToSend = (paramString as NSString).dataUsingEncoding(NSUTF8StringEncoding)
        var requestBodyData: NSData = dataToSend
        request.HTTPBody = requestBodyData
        var task = session.dataTaskWithRequest(request)
        task.resume()
        var err: NSError?
        return err
    }
    
    func registerHTTPPost(tempUsername: String, tempPassword: String) -> Int
    {
        var request = NSMutableURLRequest(URL: NSURL(string: "http://54.191.143.176:4567/users/new"))
        var session = NSURLSession.sharedSession()
        request.HTTPMethod = "POST"
        var paramString = "&username=" + tempUsername + "&password=" + tempPassword + "&first_name=NI&last_name=NI"
        let dataToSend = (paramString as NSString).dataUsingEncoding(NSUTF8StringEncoding)
        var requestBodyData: NSData = dataToSend
        request.HTTPBody = requestBodyData
        var task = session.dataTaskWithRequest(request)
        task.resume()
    }
}
