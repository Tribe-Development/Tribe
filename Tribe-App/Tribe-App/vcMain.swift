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
    override func viewDidAppear(animated: Bool) {
        login()
    }
    func login() {
        var loginAlert:UIAlertController = UIAlertController(title: "Sign Up / Login", message: "Login to Join Your Tribe!", preferredStyle: UIAlertControllerStyle.Alert)
        
        loginAlert.addTextFieldWithConfigurationHandler({
            textfield in
            textfield.placeholder = "Username"
            })
        
        loginAlert.addTextFieldWithConfigurationHandler({
            textfield in
            textfield.placeholder = "Password"
            textfield.secureTextEntry = true
            })
        
        loginAlert.addAction(UIAlertAction(title: "Sign Up", style: UIAlertActionStyle.Default, handler: {
            alertAction in
            let textFields:NSArray = loginAlert.textFields as NSArray
            let usernameTextfield:UITextField = textFields.objectAtIndex(0) as UITextField
            let passwordTextfield:UITextField = textFields.objectAtIndex(1) as UITextField
            self.completeRegistration(true, username: usernameTextfield.text, password: passwordTextfield.text)
            }))
        
        loginAlert.addAction(UIAlertAction(title: "Login", style: UIAlertActionStyle.Default, handler: {
            alertAction in
            let textFields:NSArray = loginAlert.textFields as NSArray
            let usernameTextfield:UITextField = textFields.objectAtIndex(0) as UITextField
            let passwordTextfield:UITextField = textFields.objectAtIndex(1) as UITextField
            self.loginHTTPPost(usernameTextfield.text, tempPassword: passwordTextfield.text)
            }))
        
        self.presentViewController(loginAlert, animated: true, completion: nil)
    }
    
    func completeRegistration(animated: Bool, username: String, password: String) {
        var loginAlert:UIAlertController = UIAlertController(title: "Complete Registration", message: "Enter your name to join a Tribe!", preferredStyle: UIAlertControllerStyle.Alert)
        
        loginAlert.addTextFieldWithConfigurationHandler({
            textfield in
            textfield.placeholder = "First Name"
            })
        
        loginAlert.addTextFieldWithConfigurationHandler({
            textfield in
            textfield.placeholder = "Last Name"
            textfield.secureTextEntry = true
            })
        
        loginAlert.addAction(UIAlertAction(title: "Sign Up", style: UIAlertActionStyle.Default, handler: {
            alertAction in
            let textFields:NSArray = loginAlert.textFields as NSArray
            let firstNameTextfield:UITextField = textFields.objectAtIndex(0) as UITextField
            let lastNameTextfield:UITextField = textFields.objectAtIndex(1) as UITextField
            self.registerHTTPPost(username, tempPassword: password, firstName: firstNameTextfield.text, lastName: lastNameTextfield.text)
            }))
        
        self.presentViewController(loginAlert, animated: true, completion: nil)
    }
    
    func loginHTTPPost(tempUsername: String, tempPassword: String) -> Void {
        var request = NSMutableURLRequest(URL: NSURL(string: "http://54.191.143.176:4567/login"))
        var session = NSURLSession.sharedSession()
        request.HTTPMethod = "POST"
        var paramString = "&username=\(tempUsername)&password=\(tempPassword)"
        let dataToSend = (paramString as NSString).dataUsingEncoding(NSUTF8StringEncoding)
        var requestBodyData: NSData = dataToSend
        request.HTTPBody = requestBodyData
        var responseCode: Int = 666
        var task = session.dataTaskWithRequest(request, completionHandler: {data, response, error -> Void in
            let httpResp: NSHTTPURLResponse = response as NSHTTPURLResponse
            println("Response: \(response)")
            var strData = NSString(data: data, encoding: NSUTF8StringEncoding)
            println("Body: \(strData)")
            var err: NSError?
            responseCode = httpResp.statusCode
            self.loginCheck(responseCode)
            })
        task.resume()
    }
    
    func registerHTTPPost(tempUsername: String, tempPassword: String, firstName: String, lastName: String) -> Void {
        var request = NSMutableURLRequest(URL: NSURL(string: "http://54.191.143.176:4567/users/new"))
        var session = NSURLSession.sharedSession()
        request.HTTPMethod = "POST"
        var paramString = "&username=\(tempUsername)&password=\(tempPassword)"
        paramString += "&first_name=\(firstName)&last_name=\(lastName)"
        let dataToSend = (paramString as NSString).dataUsingEncoding(NSUTF8StringEncoding)
        var requestBodyData: NSData = dataToSend
        request.HTTPBody = requestBodyData
        var responseCode: Int = 666
        var task = session.dataTaskWithRequest(request, completionHandler: {data, response, error -> Void in
            let httpResp: NSHTTPURLResponse = response as NSHTTPURLResponse
            println("Response: \(response)")
            var strData = NSString(data: data, encoding: NSUTF8StringEncoding)
            println("Body: \(strData)")
            var err: NSError?
            responseCode = httpResp.statusCode
            self.registrationCheck(responseCode)
            })
        task.resume()
    }
    
    func registrationCheck(responseCode: Int)-> Int
    {
        //TODO: Implement this shit
        if(responseCode == 200)
        {
            return 1
        }
        else if(responseCode == 100)
        {
            return 1
        }
        else
        {
            return 1
        }
    }
    
    func loginCheck(responseCode: Int)-> Int
    {
        //TODO: Implement this shit
        if(responseCode == 200)
        {
            return 1
        }
        else if(responseCode == 100)
        {
            return 1
        }
        else
        {
            return 1
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

}
