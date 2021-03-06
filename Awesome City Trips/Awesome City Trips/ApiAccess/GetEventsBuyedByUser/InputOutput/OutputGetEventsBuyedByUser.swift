//
//  OutputGetEventsBuyedByUser.swift
//  Awesome City Trips
//
//  Created by Rigoberto Saenz on 8/30/18.
//  Copyright © 2018 Awesome City Team. All rights reserved.
//

import Foundation

struct OutputGetEventsBuyedByUser: Codable {
    let status: ApiRequestResult
    let events: [Event]
}
