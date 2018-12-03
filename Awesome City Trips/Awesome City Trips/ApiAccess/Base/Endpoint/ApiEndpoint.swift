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
    case getCreditCardsFromUser(userId: String)
    case buyEvent(userId: String, creditCardId: Int64, eventId: Int64)
    case getEventFromLocation(coordinates: Coordinates, numberofNearEvents: Int)
    case getEventsBuyedByUser(userId: String)
    case getUserInfo(userId: String)
    case setUserInfo(input: InputSetUserInfo)
    case addCardToUser(input: InputAddCardToUser)
}
