//
//  User.swift
//  Awesome City Trips
//
//  Created by Rigoberto Saenz on 8/30/18.
//  Copyright © 2018 Awesome City Team. All rights reserved.
//

import Foundation

struct User: Codable {
    let token: String
    let firstName: String
    let lastName: String
    let picture: String
    let email: String
    let birthday: String
    let username: String
    let password: String
    
    // MARK: Decoding & Encoding to JSON
    enum CodingKeys: String, CodingKey {
        case token
        case firstName
        case lastName
        case picture
        case email
        case birthday
        case username
        case password
    }
}
