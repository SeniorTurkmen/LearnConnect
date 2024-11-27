//
//  Supabase+Client.swift
//  DataProvider
//
//  Created by Mustafa Turkmen on 25.11.2024.
//

import Environments
import Foundation

public protocol SupabaseClient: DecodableResponseRequest {}

// MARK: - RequestEncoding
public extension SupabaseClient {
    var encoding: RequestEncoding {
        switch method {
        case .get, .put:
            return .url

        case .post:
            return .json

        default:
            return .json
        }
    }
}

// MARK: - url
public extension SupabaseClient {
    var url: String {
        ServiceURLs.serviceURL + path
    }
}

// MARK: - RequestParameters
public extension SupabaseClient {
    var parameters: RequestParameters {
        [:]
    }
}

// MARK: - RequestHeaders
public extension SupabaseClient {
    var headers: RequestHeaders {
        var baseHeader: RequestHeaders = [:]
        let key = "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzdXBhYmFzZSIsInJlZiI6ImtvaHR3cGdjdnFlc25vdHZ3ZW1nIiwicm9sZSI6ImFub24iLCJpYXQiOjE3MzI1NTY1NzQsImV4cCI6MjA0ODEzMjU3NH0.OAjtmwMS8pDs67UWStpyqOEM_7VfGIrSPWaft18gYnI"
        baseHeader["apikey"] = key
        baseHeader["Authorization"] = "Bearer \(key)"
        return baseHeader
    }
}
