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
    
    // MARK: Decoding & Encoding to JSON
    enum CodingKeys: String, CodingKey {
        case token
        case issuerIconUrl = "issuer_icon_url"
        case firstSixDigits = "first_six_digits"
        case lastFourDigits = "last_four_digits"
    }
    
    init(token: String, firstSixDigits: String, issuerIconUrl: String, lastFourDigits: String) {
        self.token = token
        self.firstSixDigits = firstSixDigits
        self.issuerIconUrl = issuerIconUrl
        self.lastFourDigits = lastFourDigits
    }
}
