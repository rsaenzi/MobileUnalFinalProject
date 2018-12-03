//
//  OutputSetUserInfo.swift
//  Awesome City Trips
//
//  Created by Rigoberto Sáenz Imbacuán on 12/2/18.
//  Copyright © 2018 Awesome City Team. All rights reserved.
//

import Foundation

struct OutputSetUserInfo: Codable {
    let status: ApiRequestResult
    let user: User
    
    // MARK: Decoding & Encoding to JSON
    enum CodingKeys: String, CodingKey {
        case status
        case user = "datos"
    }
}
