//
//  RequestApi.swift
//  Awesome City Trips
//
//  Created by Rigoberto Saenz on 8/30/18.
//  Copyright © 2018 Awesome City Team. All rights reserved.
//

import Foundation
import Reachability
import Moya
import Result

typealias CompletionApiRequest = (_ response: ResponseApi) -> Void

class RequestApi {
    
    private init() {}
    
    static func request(to endpoint: ApiEndpoint, authenticate: Bool = false,
                        completion callback: @escaping CompletionApiRequest) {
        
        // Here we perform the first Internet connection testing
        let host = "\(endpoint.baseURL)\(endpoint.path)"
        if let reach = Reachability(hostname: host), reach.connection == .none {
            
            // Only for debugging
            ApiUtils.printNoInternet(using: endpoint)
            
            // WiFi ans Cellular connections are off
            callback(.offline(error: LogMessage.noConnection.rawValue))
            return
        }
        
        // Operations before sending a request can be added here
        var plugins = [PluginType]()
        
        // Only for debugging
        if BuildConfiguration.isNotRelease {
            plugins.append(PrintRequest())
        }
        
//        // If authentication via JSON Web Token is requested
//        if authenticate {
//            plugins.append(AddAuthenticationToken())
//        }
        
        // Here we perform the request
        let provider = MoyaProvider<ApiEndpoint>(plugins: plugins)
        provider.request(endpoint) { result in
            
            // Only for debugging
            ApiUtils.printResponse(result, endpoint: endpoint)
            
            switch result {
                
            case .success(let data):
                
                // Success http code or Error not handled properly by server,
                // in this case, calling Request must detect and process the error
                guard data.statusCode >= 400, let jsonString = ApiUtils.getJsonString(from: data) else {
                    callback(.received(result: data))
                    return
                }
                
//                // Here we are trying to detect if the error was handled by the server
//                if let errorFull: ServerErrorFull = jsonString.decodeFrom() {
//                    callback(.error(result: data, error: errorFull.message))
//                    return
//                }
//                if let errorSimple: ServerErrorSimple = jsonString.decodeFrom() {
//                    callback(.error(result: data, error: errorSimple.message))
//                    return
//                }
                
                // Http error not handled properly by server, so must be processed by calling Request
                callback(.received(result: data))
                
            case .failure(let requestError):
                
                // Let's determine if the failure was caused by a internet connectivity problem
                switch requestError {
                case .underlying(let swiftError as NSError, _):
                    
                    switch swiftError.code {
                        
                    case -1001: // Reason: The request timed out
                        callback(.timeOut(error: requestError.localizedDescription))
                        return
                        
                    case -1009: // Reason: The Internet connection appears to be offline
                        callback(.offline(error: requestError.localizedDescription))
                        return
                        
                    default:
                        break
                    }
                default:
                    break
                }
                
                // The error was caused by a different reason
                callback(.failure(error: requestError.localizedDescription))
            }
        }
    }
}

//// MARK: Plugin for Authorization
//struct AddAuthenticationToken: PluginType {
//
//    /// Called to modify a request before sending
//    func prepare(_ request: URLRequest, target: TargetType) -> URLRequest {
//
//        var token: String? = nil
//
//        switch target {
//        case ApiEndpoint.registerUser, ApiEndpoint.getSessionToken:
//
//            guard let registrationToken = KeychainStore.shared.get(from: .apiRegistrationToken) else {
//                Log.shared.log(.registrationTokenError, level: .error, from: .apiRequest)
//                return request
//            }
//            token = registrationToken
//
//        default:
//            guard let sessionToken = KeychainStore.shared.get(from: .apiSessionToken) else {
//                Log.shared.log(.sessionTokenError, level: .error, from: .apiRequest)
//                return request
//            }
//            token = sessionToken
//        }
//
//        // Here we inject the token to the request
//        var authenticatedRequest = request
//        authenticatedRequest.setValue(token, forHTTPHeaderField: "X-Authentication-Token")
//        return authenticatedRequest
//    }
//}

// MARK: Plugin for Logging
struct PrintRequest: PluginType {
    
    /// Called immediately before a request is sent over the network (or stubbed).
    func willSend(_ request: RequestType, target: TargetType) {
        ApiUtils.print(request: request.request!)
    }
}
