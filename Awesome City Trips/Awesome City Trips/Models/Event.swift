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
    let name: String
    let iconUrl: String
    let placeName: String
    let coordinates: Coordinates
    let rating: Int
    let gallery: [String]
    let availableSeats: Int
    let eventDate: [EventDate]
    let organizer: Organizer
}
