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
    let iconUrl: String
    let galleryUrls: [String]
    let placeName: String
    let placeCoordinates: Coordinates
    let totalSeats: Int
    let availableSeats: Int
    let rating: Int
    let date: Date
    let price: Double
    let organizer: Organizer
}
