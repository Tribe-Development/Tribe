//
//  vcMain.swift
//  Tribe-App
//
//  Created by Charlie Martell on 7/11/14.
//  Copyright (c) 2014 TheTribe. All rights reserved.
//

import UIKit
import CoreData

//NOTE: I currently have all of the Core Data stuff commented out because its buggy atm

class vcMain: UIViewController {
    let userDefaults = NSUserDefaults.standardUserDefaults()
    
    func setupHomeView(){
        var imageView = UIImageView(frame: CGRectMake(0, 0, 320, 450));
        var image = UIImage(named: "tribe.jpg");
        imageView.image = image;
        self.view.addSubview(imageView);
        
        //Login Button
        let loginButton : UIButton = UIButton.buttonWithType(UIButtonType.Custom) as UIButton
        loginButton.frame = CGRectMake(0, 450, 320, 59)
        loginButton.backgroundColor = UIColorFromRGB(0x1A9A91)
        loginButton.addTarget(self, action: Selector("loginAlert"), forControlEvents: UIControlEvents.TouchUpInside)
        loginButton.setTitle("Login", forState: UIControlState.Normal)
        self.view.addSubview(loginButton)
        
        //Sign Up Button
        let signUpButton : UIButton = UIButton.buttonWithType(UIButtonType.Custom) as UIButton
        signUpButton.frame = CGRectMake(0, 509, 320, 59)
        signUpButton.backgroundColor = UIColorFromRGB(0xF37896)
        signUpButton.addTarget(self, action: Selector("registerAlert"), forControlEvents: UIControlEvents.TouchUpInside)
        signUpButton.setTitle("Sign Up", forState: UIControlState.Normal)
        self.view.addSubview(signUpButton)
    }
    
    func clearUserDefaults() {
        userDefaults.removeObjectForKey("username")
        userDefaults.removeObjectForKey("password")
        userDefaults.removeObjectForKey("serial")
    }
    
    func getUserDefaults() -> NSDictionary {
        var userUsername: AnyObject? = userDefaults.objectForKey("username")
        var userPassword: AnyObject? = userDefaults.objectForKey("password")
        var userSerial: AnyObject? = userDefaults.objectForKey("serial")
        var userDict: NSDictionary = ["username": userUsername,"password": userPassword, "serial": userSerial]
        return userDict
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
    
    //TODO: Rework these 3 methods to support scrolling up
    func loginAlert() {
        var loginAlert:UIAlertController = UIAlertController(title: "Login!", message: "Login to Join Your Tribe!", preferredStyle: UIAlertControllerStyle.Alert)
        
        loginAlert.addTextFieldWithConfigurationHandler({
            textfield in
            textfield.placeholder = "Username"
            })
        
        loginAlert.addTextFieldWithConfigurationHandler({
            textfield in
            textfield.placeholder = "Password"
            textfield.secureTextEntry = true
            })
        
        loginAlert.addAction(UIAlertAction(title: "Login", style: UIAlertActionStyle.Default, handler: {
            alertAction in
            let textFields:NSArray = loginAlert.textFields as NSArray
            let usernameTextfield:UITextField = textFields.objectAtIndex(0) as UITextField
            let passwordTextfield:UITextField = textFields.objectAtIndex(1) as UITextField
            self.loginHTTPPost(usernameTextfield.text, tempPassword: passwordTextfield.text)
            }))
        
        self.presentViewController(loginAlert, animated: true, completion: nil)
    }
    
    func registerAlert() {
        var loginAlert:UIAlertController = UIAlertController(title: "Sign Up", message: "Sign Up to Join Your Tribe!", preferredStyle: UIAlertControllerStyle.Alert)
        
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
            self.completeRegistrationAlert(true, username: usernameTextfield.text, password: passwordTextfield.text)
            }))
        
        self.presentViewController(loginAlert, animated: true, completion: nil)
    }
    
    func completeRegistrationAlert(animated: Bool, username: String, password: String) {
        var loginAlert:UIAlertController = UIAlertController(title: "Complete Registration", message: "Enter your name to join a Tribe!", preferredStyle: UIAlertControllerStyle.Alert)
        
        loginAlert.addTextFieldWithConfigurationHandler({
            textfield in
            textfield.placeholder = "First Name"
            })
        
        loginAlert.addTextFieldWithConfigurationHandler({
            textfield in
            textfield.placeholder = "Last Name"
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
        var serial: AnyObject = "Did not Initialize"
        var responseCode: Int = 666
        //Closure executes after task.resume()
        var task = session.dataTaskWithRequest(request, completionHandler: {data, response, error -> Void in
            let httpResp: NSHTTPURLResponse = response as NSHTTPURLResponse
            println("Response: \(response)")
            var err: NSError?
            //Don't parse json if there is none
            if(data.length > 0) {
                var jsonResponse = NSJSONSerialization.JSONObjectWithData(data, options: .MutableLeaves, error: &err) as NSDictionary
                responseCode = httpResp.statusCode
                if(responseCode == 200) {
                    serial = jsonResponse.valueForKey("token")
                }
                println(serial)
            }
            self.loginCheck(responseCode, tempUsername: tempUsername, tempPassword: tempPassword, tempSerial: serial as String)
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
        var serial: AnyObject = "Did not Initialize"
        var responseCode: Int = 666
        //Closure executes after task.resume()
        var task = session.dataTaskWithRequest(request, completionHandler: {data, response, error -> Void in
            let httpResp: NSHTTPURLResponse = response as NSHTTPURLResponse
            println("Response: \(response)")
            var err: NSError?
            //Don't parse json if there is none
            if(data.length > 0)
            {
                var jsonResponse = NSJSONSerialization.JSONObjectWithData(data, options: .MutableLeaves, error: &err) as NSDictionary
                println(jsonResponse)
                responseCode = httpResp.statusCode
                if(responseCode == 200)
                {
                    serial = jsonResponse.valueForKey("token")
                }
            }
            self.registrationCheck(responseCode, tempUsername: tempUsername, tempPassword: tempPassword, tempSerial: serial as String)
            })
        task.resume()
    }

    func loginCheck(responseCode: Int, tempUsername: String, tempPassword: String, tempSerial: String)-> Void {
        if(responseCode == 200) {
            clearUserDefaults()
            userDefaults.setObject(tempUsername, forKey:"username")
            userDefaults.setObject(tempPassword, forKey:"password")
            userDefaults.setObject(tempSerial, forKey:"serial")
            userDefaults.synchronize()
            self.performSegueWithIdentifier("loggedIn", sender: self)
        }
        else if(responseCode == 400) {
            badRequest()
        }
        else {
            forbiddenRequest("login")
        }
    }
    
    func registrationCheck(responseCode: Int, tempUsername: String, tempPassword: String, tempSerial: String)-> Void {
        if(responseCode == 200) {
            clearUserDefaults()
            userDefaults.setObject(tempUsername, forKey:"username")
            userDefaults.setObject(tempPassword, forKey:"password")
            userDefaults.setObject(tempSerial, forKey:"serial")
            userDefaults.synchronize()
            self.performSegueWithIdentifier("loggedIn", sender: self)
        }
        else if(responseCode == 400) {
            badRequest()
        }
        else if(responseCode == 403) {
            forbiddenRequest("registration")
        }
    }
    
    func badRequest() {
        var loginAlert:UIAlertController = UIAlertController(title: "Error Bad Request", message: "Please check your parameters and try again!", preferredStyle: UIAlertControllerStyle.Alert)
        loginAlert.addAction(UIAlertAction(title: "Try Again", style: UIAlertActionStyle.Default, handler: {
            alertAction in
            self.loginAlert()
            }))

        self.presentViewController(loginAlert, animated: true, completion: nil)
    }
    
    func forbiddenRequest(type: String) {
        if(type == "registration")
        {
            var loginAlert:UIAlertController = UIAlertController(title: "User Already Exists", message: "Incorrect User/Pass please check and try again!", preferredStyle: UIAlertControllerStyle.Alert)
            loginAlert.addAction(UIAlertAction(title: "Try Again", style: UIAlertActionStyle.Default, handler: {
                alertAction in
                self.loginAlert()
                }))
            self.presentViewController(loginAlert, animated: true, completion: nil)
        }
        else if(type == "login")
        {
            var loginAlert:UIAlertController = UIAlertController(title: "Incorrect Credentials", message: "Incorrect User/Pass please check and try again!", preferredStyle: UIAlertControllerStyle.Alert)
            loginAlert.addAction(UIAlertAction(title: "Try Again", style: UIAlertActionStyle.Default, handler: {
                alertAction in
                self.loginAlert()
                }))
            self.presentViewController(loginAlert, animated: true, completion: nil)
        }
    }
    
    override func viewDidAppear(animated: Bool) {
        var userUsername: AnyObject? = userDefaults.objectForKey("username")
        if(userUsername != nil) {
            performSegueWithIdentifier("loggedIn", sender: self)
        }
        else {
            setupHomeView()
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
