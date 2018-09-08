//
//  Place.swift
//  Awesome City Trips
//
//  Created by Rigoberto Sáenz Imbacuán on 9/7/18.
//  Copyright © 2018 Awesome City Team. All rights reserved.
//

import Foundation

struct Place: Codable {
    let id: Int64
    let name: String
    let coordinates: Coordinates
    
    // MARK: Decoding & Encoding to JSON
    enum CodingKeys: String, CodingKey {
        case id
        case name
        case coordinates
    }
}
