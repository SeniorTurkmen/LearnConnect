//
//  ResourcesBundle.swift
//
//
//  Created by Mustafa Turkmen on 25.11.2024.
//

import Foundation

public final class ResourcesBundle {
    /// - `AppResources` shared instance
    public static var shared = ResourcesBundle()

    public static let bundle: Bundle = {
        #if SWIFT_PACKAGE
        return Bundle.module
        #else
        return Bundle(for: Resources.self)
        #endif
    }()

    // MARK: - Properties
    public var baseURL: String
    public var cdnURL: String

    // MARK: - Init
    private init() {
        baseURL = ""
        cdnURL = ""
    }
}
