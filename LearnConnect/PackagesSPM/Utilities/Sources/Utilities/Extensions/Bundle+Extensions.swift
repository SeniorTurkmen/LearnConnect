//
//  Bundle+Extensions.swift
//  Utilities
//
//  Created by Mustafa Turkmen on 25.11.2024.
//

import Foundation

private enum Keys {
    static let shortVersion = "CFBundleShortVersionString"
    static let version = "CFBundleVersion"
    static let executable = "CFBundleExecutable"
    static let bundleName = "CFBundleName"
    static let bundleId = "CFBundleIdentifier"
}

private enum Const {
    static let unknown = "Unknown"
}

public extension Bundle {
    var releaseVersionNumber: String? {
        return infoDictionary?[Keys.shortVersion] as? String
    }
    var buildVersionNumber: String? {
        return infoDictionary?[Keys.version] as? String
    }

    func appName() -> String {
        guard let dictionary = Bundle.main.infoDictionary else {
            return ""
        }
        if let version: String = dictionary[Keys.bundleName] as? String {
            return version
        } else {
            return ""
        }
    }

    var bundleIdentifier: String? {
        return infoDictionary?[Keys.bundleId] as? String
    }

    var trimmedAppVersion: String {
        let version = object(forInfoDictionaryKey: Keys.shortVersion) as? String ?? Const.unknown
        let splitted = version.split(separator: ".")
        var trimmedVersion: String = ""
        if splitted.count == 4 {
            for index in 0..<splitted.count - 1 {
                if index != 0 {
                    trimmedVersion.append(contentsOf: ".")
                }
                trimmedVersion.append(contentsOf: splitted[index])
            }
            return trimmedVersion
        } else {
            return version
        }
    }
}
