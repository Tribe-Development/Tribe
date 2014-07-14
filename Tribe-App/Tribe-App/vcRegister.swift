//
//  vcRegister.swift
//  Tribe-App
//
//  Created by Charlie Martell on 7/12/14.
//  Copyright (c) 2014 TheTribe. All rights reserved.
//

import UIKit

class vcRegister: UIViewController {

   
    @IBOutlet var firstField: UITextField
    @IBOutlet var lastField: UITextField
    
    @IBAction func registerButton(sender: AnyObject) {
        checkValid()
    }
    func checkValid() -> Bool {
        
        return true
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

}
