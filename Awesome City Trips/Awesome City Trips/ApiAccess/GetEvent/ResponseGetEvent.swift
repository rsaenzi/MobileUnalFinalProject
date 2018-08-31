//
//  ResponseGetEvent.swift
//  Awesome City Trips
//
//  Created by Rigoberto Saenz on 8/30/18.
//  Copyright © 2018 Awesome City Team. All rights reserved.
//

import Moya

enum ResponseGetEvent {
    
    // Specific Responses
    case success(output: OutputGetEvent)
    case unauthorized(jsonString: String)
    
    // Response Errors
    case serverError(reason: String)
    case invalidStatusCode(statusCode: Int)
    case httpRedirectionError(statusCode: Int)
    case httpClientError(statusCode: Int)
    case httpServerError(statusCode: Int)
    
    // Request Errors
    case resultDataError(response: Moya.Response)
    case jsonDecodingError(jsonString: String)
    case requestFailure(reason: String)
    case noInternet
}
