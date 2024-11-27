//
//  File.swift
//  
//
//  Created by Mustafa Turkmen on 25.11.2024.
//

import Foundation

/// Define log level
public enum LogLevel: Int, Comparable {
    /// No logs - default
    case none = 0
    /// Error logs only
    case error = 1
    /// Enable warning logs
    case warning = 2
    /// Enable info logs
    case info = 3
    /// Enable all logs
    case debug = 4

    func toString() -> String {
        switch self {
        case .none:
            return ""
        case .error:
            return "🔴"
        case .warning:
            return "🟠"
        case .info:
            return "🔵"
        case .debug:
            return "🟢"
        }
    }

    public static func < (lhs: LogLevel, rhs: LogLevel) -> Bool {
        return lhs.rawValue < rhs.rawValue
    }

    static func all() -> [LogLevel] {
        return [.none, .error, .warning, .info, .debug]
    }
}
