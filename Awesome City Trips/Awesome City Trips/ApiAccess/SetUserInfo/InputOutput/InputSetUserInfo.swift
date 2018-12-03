//
//  InputSetUserInfo.swift
//  Awesome City Trips
//
//  Created by Rigoberto Sáenz Imbacuán on 12/2/18.
//  Copyright © 2018 Awesome City Team. All rights reserved.
//

import Foundation

struct InputSetUserInfo: Codable {
    var token: String
    var firstName: String
    var lastName: String
    var picture: String
    var email: String
    var birthday: String
    var username: String
    var password: String
    
    init(token: String, firstName: String, lastName: String, picture: String, email: String, birthday: String, username: String, password: String) {
        self.token = token
        self.firstName = firstName
        self.lastName = lastName
        self.picture = picture
        self.email = email
        self.birthday = birthday
        self.username = username
        self.password = password
    }
}
