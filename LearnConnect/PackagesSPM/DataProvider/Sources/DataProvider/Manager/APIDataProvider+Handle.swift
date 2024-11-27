//
//  APIDataProvider+Handle.swift
//
//
//  Created by Mustafa Turkmen on 25.11.2024.
//

import Alamofire
import Foundation

public extension APIDataProvider {
    func handle<T: Decodable>(
        error: AFError,
        responseData: AFDataResponse<T>,
        completion: DataProviderResult<T>? = nil
    ) {
        let customError = processStatusCode(responseData: responseData, error: error)

        let errorResponse = BaseResponseError(
            dataResponse: responseData,
            error: customError
        )
        completion?(.failure(errorResponse))
    }
}
