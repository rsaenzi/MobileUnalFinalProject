//
//  ApiEndpoint.swift
//  Awesome City Trips
//
//  Created by Rigoberto Saenz on 8/30/18.
//  Copyright © 2018 Awesome City Team. All rights reserved.
//

import Foundation

enum ApiEndpoint {
    case getCategories
    case getEventsFromCategory(categoryId: Int64)
    case getEvent(eventId: Int64)
    case getCreditCardsFromUser(userId: Int64)
    case buyEvent(userId: Int64, creditCardId: Int64, eventId: Int64)
    case getEventFromLocation(coordinates: Coordinates, numberofNearEvents: Int)
    case getEventsBuyedByUser(userId: Int64)
    case getUserInfo(userId: Int64)
    case getUserID(username: Int64, password: Int64) // Oauth?
}
