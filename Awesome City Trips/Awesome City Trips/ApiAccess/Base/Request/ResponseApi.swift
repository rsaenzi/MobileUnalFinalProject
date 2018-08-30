//
//  ResponseApi.swift
//  Awesome City Trips
//
//  Created by Rigoberto Saenz on 8/30/18.
//  Copyright © 2018 Awesome City Team. All rights reserved.
//

import Moya

enum ResponseApi {
    case received(result: Response)
    case error(result: Response, error: String)
    case failure(error: String)
    case offline(error: String)
    case timeOut(error: String)
}
