//
//  File.swift
//  
//
//  Created by Mustafa Turkmen on 25.11.2024.
//

import Foundation

public class Logger {
    private var logLevel: LogLevel = .none

    private var logEntryDateFormatter: DateFormatter = {
        let formatter = DateFormatter()
        formatter.locale = Locale(identifier: "en_US_POSIX")
        formatter.dateFormat = "yyyy-MM-dd HH:mm:ss.SSSS"
        return formatter
    }()

    public init() {
        #if GADGET
        self.logLevel = .debug
        #else
        self.logLevel = .none
        #endif
    }

    public init(logLevel: LogLevel) {
        self.logLevel = logLevel
    }

    public func configure(logLevel: LogLevel) {
        self.logLevel = logLevel
    }

    public func error(
        file: String = #file,
        function: String = #function,
        line: Int = #line,
        message: String,
        arguments: CVarArg...
    ) {
        log(
            file: file,
            function: function,
            line: line,
            logLevel: .error,
            message: message,
            arguments: arguments
        )
    }

    public func warning(
        file: String = #file,
        function: String = #function,
        line: Int = #line,
        message: String,
        arguments: CVarArg...
    ) {
        log(
            file: file,
            function: function,
            line: line,
            logLevel: .warning,
            message: message,
            arguments: arguments
        )
    }

    public func info(
        file: String = #file,
        function: String = #function,
        line: Int = #line,
        message: String,
        arguments: CVarArg...
    ) {
        log(
            file: file,
            function: function,
            line: line,
            logLevel: .info,
            message: message,
            arguments: arguments
        )
    }

    public func debug(
        file: String = #file,
        function: String = #function,
        line: Int = #line,
        message: String,
        arguments: CVarArg...
    ) {
        log(
            file: file,
            function: function,
            line: line,
            logLevel: .debug,
            message: message,
            arguments: arguments
        )
    }
}

extension Logger {
    // swiftlint: disable function_parameter_count
    private func log(
        file: String,
        function: String,
        line: Int,
        logLevel: LogLevel,
        message: String,
        arguments: CVarArg...
    ) {
        guard self.logLevel != .none else { return }

        let dateStr = logEntryDateFormatter.string(from: Date())
        let logMessage = String.safely(format: message, arguments)
        let message = """

        \(logLevel.toString()) [\(dateStr)]: \(sourceFileName(file)).\(function) (\(line))
        \(logMessage)
        """
        print(message)
    }
    // swiftlint: enable function_parameter_count

    private func sourceFileName(_ filePath: String) -> String {
        let components = filePath.components(separatedBy: "/")
        return components.isEmpty ? "" : (components.last ?? "")
    }
}


fileprivate extension String {
    // https://en.wikipedia.org/wiki/Printf_format_string
    private static var formatCharacters: Set<Character> {
        "@diufFeEgGxXoscpaAn".reduce(into: []) { $0.insert($1) }
    }

    static func safely(format template: String, _ params: CVarArg...) -> String {
        var potentialPattern = false
        var patternCount = 0
        for char in template {
            switch char {
            case "%":
                // %% or %
                potentialPattern.toggle()
            case let x where formatCharacters.contains(x) && potentialPattern:
                patternCount += 1
                potentialPattern = false
            case let x where !x.isWhitespace:
                potentialPattern = false
            default:
                break
            }
        }
        return String(format: template, arguments: params)
    }
}
