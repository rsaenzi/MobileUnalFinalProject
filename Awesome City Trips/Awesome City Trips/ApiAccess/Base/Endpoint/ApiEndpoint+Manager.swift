//
//  ApiEndpoint+Manager.swift
//  Awesome City Trips
//
//  Created by Rigoberto Saenz on 8/30/18.
//  Copyright © 2018 Awesome City Team. All rights reserved.
//

import Moya

extension ApiEndpoint: TargetType {
    
    var baseURL: URL {
        return URL(string: "https://us-central1-awesomecitytrips.cloudfunctions.net")!
    }
    
    var path: String {
        
        switch self {
        
        case .getCategories:
            return "/getCategories"
            
        case .getEventsFromCategory(let categoryId):
            return "/getEventsFromCategory/\(categoryId)"
            
        case .getEvent(let eventId):
            return "/getEvent/\(eventId)"
            
        case .getCreditCardsFromUser(let userId):
            return "/getCreditCardsFromUser/\(userId)"
            
        case .buyEvent:
            return "/buyEvent"
            
        case .getEventFromLocation(let coordinates, let numberofNearEvents):
            return "/getEventFromLocation/\(coordinates.latitude)/\(coordinates.longitude)/\(numberofNearEvents)"
            
        case .getEventsBuyedByUser(let userId):
            return "/getEventsBuyedByUser/\(userId)"
            
        case .getUserInfo:
            return "/getUserInfo"
            
        case .getUserId:
            return "/getUserId"
        }
    }
    
    var method: Method {
        return .get
    }
    
    var headers: [String: String]? {
        var headers = [String: String]()
        headers["Accept"] = "application/json"
        headers["Content-type"] = "application/json"
        return headers
    }
    
    var task: Task {
        
        switch self {
        
        case .getCategories:
            return Task.requestPlain
            
        case .getEventsFromCategory:
            return .requestPlain
            
        case .getEvent:
            return .requestPlain
            
        case .getCreditCardsFromUser:
            return .requestPlain
            
        case .buyEvent(let userId, let creditCardId, let eventId):
            return .requestParameters(
                parameters: ["userId": userId,
                             "creditCardId": creditCardId,
                             "eventId": eventId],
                encoding: URLEncoding.queryString)
            
        case .getEventFromLocation:
            return .requestPlain
            
        case .getEventsBuyedByUser:
            return .requestPlain
            
        case .getUserInfo(let userId):
            return .requestParameters(
                parameters: ["userId": userId],
                encoding: URLEncoding.queryString)
            
        case .getUserId(let username, let password):
            return .requestParameters(
                parameters: ["username": username,
                             "password": password],
                encoding: URLEncoding.queryString)
        }
    }
    
    var sampleData: Data {
        // TODO: Implement a .json file loader
        return "".utf8Encoded
    }
}
