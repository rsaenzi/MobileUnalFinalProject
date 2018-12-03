//
//  InputAddCardToUser.swift
//  Awesome City Trips
//
//  Created by Rigoberto Sáenz Imbacuán on 12/2/18.
//  Copyright © 2018 Awesome City Team. All rights reserved.
//

import Foundation

struct InputAddCardToUser: Codable {
    var token: String
    var firstSixDigits: String
    var issuerIconUrl: String
    var lastFourDigits: String
    
    init(token: String, firstSixDigits: String, issuerIconUrl: String, lastFourDigits: String) {
        self.token = token
        self.firstSixDigits = firstSixDigits
        self.issuerIconUrl = issuerIconUrl
        self.lastFourDigits = lastFourDigits
    }
}
