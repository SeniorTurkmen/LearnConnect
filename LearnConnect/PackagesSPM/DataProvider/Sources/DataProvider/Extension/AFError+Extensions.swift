//
//  AFError+Extensions.swift
//  DataProvider
//
//  Created by Mustafa Turkmen on 25.11.2024.
//

import Alamofire
import Foundation

extension AFError {
    var isTimeout: Bool {
        if isSessionTaskError,
           let error = underlyingError as NSError?, error.code == NSURLErrorTimedOut {
            return true
        }
        return false
    }
}
