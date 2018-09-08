//
//  Event.swift
//  Awesome City Trips
//
//  Created by Rigoberto Saenz on 8/30/18.
//  Copyright © 2018 Awesome City Team. All rights reserved.
//

import Foundation

struct Event: Codable {
    let id: Int64
    let categoryId: Int64
    let name: String
    let description: String
    let iconUrl: String
    let galleryUrls: [String]
    let place: Place
    let totalSeats: Int
    let availableSeats: Int
    let rating: Int
    let date: Date
    let price: Double
    let organizer: Organizer
    
    // MARK: Decoding & Encoding to JSON
    enum CodingKeys: String, CodingKey {
        case id
        case categoryId = "category_id"
        case name
        case description
        case iconUrl = "icon_url"
        case galleryUrls = "gallery_urls"
        case place
        case totalSeats = "total_seats"
        case availableSeats = "available_seats"
        case rating
        case date
        case price
        case organizer
    }
}
