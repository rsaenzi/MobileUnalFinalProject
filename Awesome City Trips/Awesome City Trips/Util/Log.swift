//
//  Log.swift
//  Awesome City Trips
//
//  Created by Rigoberto Saenz on 8/22/18.
//  Copyright © 2018 Awesome City Team. All rights reserved.
//

import Foundation

final class Log {
    
    // Singleton
    static let shared = Log()
    
    // State
    private let dateFormatter = DateFormatter()
    private var minLevel = LogLevel.debug
    
    private init() {
        dateFormatter.dateFormat = DateFormats.log.rawValue
        dateFormatter.locale = Locale.current
        dateFormatter.timeZone = TimeZone.current
    }
    
    func setMin(level: LogLevel) {
        minLevel = level
    }
    
    func log(_ item: LogMessage,
             level: LogLevel = .debug,
             from system: LogSystem = .general,
             _ fileName: String = #file,
             _ functionName: String = #function,
             _ lineNumber: Int = #line,
             _ lineColumn: Int = #column) {
        
        self.log(item.rawValue, level: level, from: system, fileName, functionName, lineNumber, lineColumn)
    }
    
    func log(_ item: @autoclosure () -> Any?,
             level: LogLevel = .debug,
             from system: LogSystem = .general,
             _ fileName: String = #file,
             _ functionName: String = #function,
             _ lineNumber: Int = #line,
             _ lineColumn: Int = #column) {
        
        // Nothing is printed if app is production...
        guard BuildConfiguration.isNotRelease else {
            return
        }
        
        // Nothing is printed if logging level is higher
        guard level.rawValue <= minLevel.rawValue else {
            return
        }
        
        // Gather all the required data
        let time = getCurrentTime()
        let file = cleanFileName(fileName)
        
        // Builds the header
        var header = "\n\(level.image()) [\(system.image()) \(system.rawValue)]  "
        header += "[🔎 \(file) → \(functionName) → Line \(lineNumber) Column \(lineColumn)] "
        header += "[🕒 \(time)]"
        
        // Validate the content to log
        var content = ""
        if let validItem = item() {
            content = "\(validItem)"
        } else {
            content = "nil"
        }
        
        // Finally we print all the data
        let data = "\(header)\n\(content)"
        print(data)
    }
}

extension Log {
    
    private func getCurrentTime() -> String {
        return dateFormatter.string(from: Date())
    }
    
    private func cleanFileName(_ filePath: String) -> String {
        let components = filePath.components(separatedBy: "/")
        return components.isEmpty ? "" : components.last!
    }
}


// MARK: On another file...
enum LogLevel: Int {
    case fatal = 0
    case error = 1
    case warning
    case important
    case info
    case debug
    
    func image() -> String {
        switch self {
        case .fatal:
            return "🔥"
        case .error:
            return "❌"
        case .warning:
            return "⚠️"
        case .important:
            return "💎"
        case .info:
            return "✅"
        case .debug:
            return "🔳"
        }
    }
}

enum LogSystem: String {
    case general = "General"
    case apiRequest = "API Request"
    case apiResponse = "API Response"
    case view = "View"
    case keychain = "Keychain"
    
    func image() -> String {
        switch self {
        case .general:
            return "📱"
        case .apiRequest:
            return "📡"
        case .apiResponse:
            return "🛰"
        case .view:
            return "🏞"
        case .keychain:
            return "🔑"
        }
    }
}

// swiftlint:disable line_length
enum LogMessage: String {
    case noConnection = "No WiFi or Cellular connection available"
    case fetchKeychainError = "Can not fetch token from Keychain to authenticate the request"
    case noteNewVsExistingUsers = "At this point is ok if 'user' is not present in the json string, that is used to differentiate between new and existing users"
}
