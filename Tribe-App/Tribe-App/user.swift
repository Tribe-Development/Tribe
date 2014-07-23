//
//  user.swift
//  Tribe-App
//
//  Created by Charlie Martell on 7/23/14.
//  Copyright (c) 2014 TheTribe. All rights reserved.
//

import Foundation

class user {
    //instance variables
    var username: String?
    var password: String?
    
    //Create new user
    init(username: String, password: String)
    {
        self.username = username
        self.password = password
    }
    
}