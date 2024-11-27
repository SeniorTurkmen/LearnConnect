//
//  DataProviderInterceptor.swift
//  LearnConnect
//
//  Created by Mustafa Turkmen on 25.11.2024.
//

import Alamofire
import Foundation

public class DataProviderInterceptor: RequestInterceptor {
    public static let shared = DataProviderInterceptor()
    let retryLimit = 1

    public func adapt(_ urlRequest: URLRequest, for session: Session, completion: @escaping (Result<URLRequest, Error>) -> Void) {
        let adaptedRequest = urlRequest
        completion(.success(adaptedRequest))
    }
}
