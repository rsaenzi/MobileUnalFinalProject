//
//  DateFormats.swift
//  Awesome City Trips
//
//  Created by Rigoberto Saenz on 8/22/18.
//  Copyright © 2018 Awesome City Team. All rights reserved.
//

import Foundation

public enum DateFormats: String {
    
    case server = "yyyy-MM-dd'T'HH:mm:ss.SSS'Z'"
    case log = "dd-MMM-yyyy h:mm:ss a"
    
    /**
     This formatter does not apply the time zone fix, must be used to fetch and send dates to the Server
     */
    public var serverFormatterUTC: DateFormatter {
        let format = DateFormatter()
        format.dateFormat = self.rawValue
        format.timeZone = TimeZone(abbreviation: "UTC")
        return format
    }
    
    /**
     This formatter applies the time zone fix, must be used to show dates to the user
     */
    public var userFormatter: DateFormatter {
        let format = DateFormatter()
        format.dateFormat = self.rawValue
        format.timeZone = TimeZone.current
        return format
    }
}
