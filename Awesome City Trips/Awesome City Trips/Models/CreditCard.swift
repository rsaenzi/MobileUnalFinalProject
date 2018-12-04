//
//  CreditCard.swift
//  Awesome City Trips
//
//  Created by Rigoberto Saenz on 8/30/18.
//  Copyright © 2018 Awesome City Team. All rights reserved.
//

import Foundation

struct CreditCard: Codable {
    //let id: Int64
    let token: String
    let issuerIconUrl: String
    let firstSixDigits: String
    let lastFourDigits: String
    
    // MARK: Decoding & Encoding to JSON
    enum CodingKeys: String, CodingKey {
        //case id
        case token
        case issuerIconUrl = "issuer_icon_url"
        case firstSixDigits = "first_six_digits"
        case lastFourDigits = "last_four_digits"
    }
}
