//
//  InputBuyEvent.swift
//  Awesome City Trips
//
//  Created by Rigoberto Sáenz Imbacuán on 12/3/18.
//  Copyright © 2018 Awesome City Team. All rights reserved.
//

import Foundation

struct InputBuyEvent: Codable {
    var token: String
    var eventId: Int64
    var eventDateId: String
    
    // MARK: Decoding & Encoding to JSON
    enum CodingKeys: String, CodingKey {
        case token
        case eventId = "event_id"
        case eventDateId = "eventDate_id"
    }
    
    init(token: String, eventId: Int64, eventDateId: String) {
        self.token = token
        self.eventId = eventId
        self.eventDateId = eventDateId
    }
}
