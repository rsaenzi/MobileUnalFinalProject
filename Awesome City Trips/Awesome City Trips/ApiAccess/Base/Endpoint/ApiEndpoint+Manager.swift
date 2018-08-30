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
        return URL(string: "https://drive.google.com")!
    }
    
    var path: String {
        
        return "/uc" // TODO: Temporal
        
        switch self {
        
        case .getCategories:
            return "/getCategories"
            
        case .getEventsFromCategory(let categoryId):
            return "/getEventsFromCategory/\(categoryId)"
            
        case .getEvent(let eventId):
            return "/getEvent/\(eventId)"
            
        case .getCreditCardsFromUser(let userId):
            return "/getCreditCardsFromUser/\(userId)"
            
        case .buyEvent(let userId, let creditCardId, let eventId):
            return "/buyEvent/\(userId), \(creditCardId), \(eventId)"
            
        case .getEventFromLocation(let coordinates, let numberofNearEvents):
            return "/getEventFromLocation/\(coordinates), \(numberofNearEvents)"
            
        case .getEventsBuyedByUser(let userId):
            return "/getEventsBuyedByUser/\(userId)"
            
        case .getUserInfo(let userId):
            return "/getUserInfo/\(userId)"
            
        case .getUserId(let username, let password):
            return "/getUserID/\(username), \(password)"
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
        
        // TODO: Temporal
        var jsonFileId = ""
        
        switch self {

        case .getCategories:
            jsonFileId = "1aVhVbR8CaYvBJ2nbgYO4jobljo67VBg8"
            
        case .getEventsFromCategory(let categoryId):
            jsonFileId = ""
            
        case .getEvent(let eventId):
            jsonFileId = ""
            
        case .getCreditCardsFromUser(let userId):
            jsonFileId = ""
            
        case .buyEvent(let userId, let creditCardId, let eventId):
            jsonFileId = ""
            
        case .getEventFromLocation(let coordinates, let numberofNearEvents):
            jsonFileId = ""
            
        case .getEventsBuyedByUser(let userId):
            jsonFileId = ""
            
        case .getUserInfo(let userId):
            jsonFileId = ""
            
        case .getUserId(let username, let password):
            jsonFileId = ""
        }
        
        return .requestParameters(
            parameters: ["id": jsonFileId],
            encoding: URLEncoding.queryString)
    }
    
    var sampleData: Data {
        // TODO: Implement a .json file loader
        return "".utf8Encoded
    }
}
