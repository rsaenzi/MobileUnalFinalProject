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
            
        case .getEventsFromCategory:
            return "/getEventsFromCategory"
            
        case .getEvent:
            return "/getEvent"
            
        case .getCreditCardsFromUser:
            return "/getCreditCardsFromUser"
            
        case .buyEvent:
            return "/buyEvent"
            
        case .getEventFromLocation:
            return "/getEventFromLocation"
            
        case .getEventsBuyedByUser:
            return "/getEventsBuyedByUser"
            
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
            
        case .getEventsFromCategory(let categoryId):
            return .requestParameters(
                parameters: ["categoryId": categoryId],
                encoding: URLEncoding.queryString)
            
        case .getEvent(let eventId):
            return .requestParameters(
                parameters: ["eventId": eventId],
                encoding: URLEncoding.queryString)
            
        case .getCreditCardsFromUser(let userId):
            return .requestParameters(
                parameters: ["userId": userId],
                encoding: URLEncoding.queryString)
            
        case .buyEvent(let userId, let creditCardId, let eventId):
            return .requestParameters(
                parameters: ["userId": userId,
                             "creditCardId": creditCardId,
                             "eventId": eventId],
                encoding: URLEncoding.queryString)
            
        case .getEventFromLocation(let coordinates, let numberofNearEvents):
            return .requestParameters(
                parameters: ["coordinates": coordinates,
                             "numberofNearEvents": numberofNearEvents],
                encoding: URLEncoding.queryString)
            
        case .getEventsBuyedByUser(let userId):
            return .requestParameters(
                parameters: ["userId": userId],
                encoding: URLEncoding.queryString)
            
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
