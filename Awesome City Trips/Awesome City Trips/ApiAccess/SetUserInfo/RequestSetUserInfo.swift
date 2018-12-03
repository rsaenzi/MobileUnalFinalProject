//
//  RequestSetUserInfo.swift
//  Awesome City Trips
//
//  Created by Rigoberto Sáenz Imbacuán on 12/2/18.
//  Copyright © 2018 Awesome City Team. All rights reserved.
//

import Moya

typealias CompletionSetUserInfo = (_ response: ResponseSetUserInfo) -> Void

class RequestSetUserInfo {
    
    private init() {}
    
    static func request(token: String, firstName: String, lastName: String, picture: String,
                        email: String, birthday: String, username: String, password: String,
                        completion callback: @escaping CompletionSetUserInfo) {
        
        let input = InputSetUserInfo(
            token: token,
            firstName: firstName,
            lastName: lastName,
            picture: picture,
            email: email,
            birthday: birthday,
            username: username,
            password: password)
        
        let endpoint = ApiEndpoint.setUserInfo(input: input)
        
        RequestApi.request(to: endpoint, authenticate: true) { response in
            switch response {
                
            case .received(let result):
                handleResponse(result, callback)
                
            case .error(_, let error):
                call(callback, .serverError(reason: error))
                
            case .failure(let error):
                call(callback, .requestFailure(reason: error))
                
            case .offline, .timeOut:
                call(callback, .noInternet)
            }
        }
    }
    
    private static func handleResponse(_ resultData: Response, _ callback: @escaping CompletionSetUserInfo) {
        
        let code = resultData.statusCode
        
        // Convert raw data into a json string
        guard let jsonString = ApiUtils.getJsonString(from: resultData) else {
            call(callback, .resultDataError(response: resultData))
            return
        }
        
        // HTTP status code validation
        switch code {
        case 200:
            handleSuccess(jsonString, callback)
            
        case 401, 403, 404:
            call(callback, .unauthorized(jsonString: jsonString))
            
        case 300...399:
            call(callback, .httpRedirectionError(statusCode: code))
            
        case 400...499:
            call(callback, .httpClientError(statusCode: code))
            
        case 500...599:
            call(callback, .httpServerError(statusCode: code))
            
        default:
            call(callback, .invalidStatusCode(statusCode: code))
        }
    }
    
    private static func handleSuccess(_ jsonString: String, _ callback: @escaping CompletionSetUserInfo) {
        
        // Converts the jsonString into a valid Object
        guard let output: OutputSetUserInfo = jsonString.decodeFrom() else {
            call(callback, .jsonDecodingError(jsonString: jsonString))
            return
        }
        
        // Returns the parsed object
        call(callback, .success(output: output))
    }
    
    private static func call(_ callback: @escaping CompletionSetUserInfo, _ result: ResponseSetUserInfo) {
        DispatchQueue.main.async {
            callback(result)
        }
    }
}
