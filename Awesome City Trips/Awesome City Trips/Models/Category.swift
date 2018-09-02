//
//  Category.swift
//  Awesome City Trips
//
//  Created by Rigoberto Saenz on 8/22/18.
//  Copyright © 2018 Awesome City Team. All rights reserved.
//

import Foundation

struct Category: Codable {
    let id: Int64
    let name: String
    let bannerUrl: String
    let description: String
    
    // MARK: Decoding & Encoding to JSON
    enum CodingKeys: String, CodingKey {
        case id
        case name
        case bannerUrl = "banner_url"
        case description
    }
}
