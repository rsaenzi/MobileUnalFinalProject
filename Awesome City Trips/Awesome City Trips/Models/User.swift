//
//  User.swift
//  Awesome City Trips
//
//  Created by Rigoberto Saenz on 8/30/18.
//  Copyright © 2018 Awesome City Team. All rights reserved.
//

import Foundation

struct User {
    let id: Int64
    let lastName: String
    let firstName: String
    let pictureUrl: String
    let email: String
    let birthday: String
    let username: String
    let password: String
    let lastAccess: Date
    let creditCard: [CreditCard]
    let buyedEvents: [Event]
}
