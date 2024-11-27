//
//  File.swift
//  
//
//  Created by Mustafa Turkmen on 25.11.2024.
//

import Foundation

public var logger = Logger(logLevel: .none)

public func log(
    file: String = #file,
    function: String = #function,
    line: Int = #line,
    _ message: String,
    _ arguments: CVarArg...
) {
    logger.debug(file: file, function: function, line: line, message: message, arguments: arguments)
}

public func log_debug(
    file: String = #file,
    function: String = #function,
    line: Int = #line,
    _ message: String,
    _ arguments: CVarArg...
) {
    logger.debug(file: file, function: function, line: line, message: message, arguments: arguments)
}

public func log_info(
    file: String = #file,
    function: String = #function,
    line: Int = #line,
    _ message: String,
    _ arguments: CVarArg...
) {
    logger.info(file: file, function: function, line: line, message: message, arguments: arguments)
}

public func log_warning(
    file: String = #file,
    function: String = #function,
    line: Int = #line,
    _ message: String,
    _ arguments: CVarArg...
) {
    logger.warning(file: file, function: function, line: line, message: message, arguments: arguments)
}

public func log_error(
    file: String = #file,
    function: String = #function,
    line: Int = #line,
    _ message: String,
    _ arguments: CVarArg...
) {
    logger.error(file: file, function: function, line: line, message: message, arguments: arguments)
}
