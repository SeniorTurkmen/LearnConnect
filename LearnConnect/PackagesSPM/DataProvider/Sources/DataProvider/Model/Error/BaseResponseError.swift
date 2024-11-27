//
//  BaseResponseError.swift
//
//
//  Created by Mustafa Turkmen on 25.11.2024.
//

import Foundation
import Alamofire

public struct BaseResponseError<T: Decodable>: Error {
    // MARK: - Variables
    public let error: NetworkError
    public let response: KDBaseResponse<T>?

    // MARK: - Init
    public init(error: NetworkError) {
        self.error = error
        self.response = nil
    }

    public init(
        dataResponse: AFDataResponse<T>,
        error: NetworkError
    ) {
        self.error = error
        guard let data = dataResponse.data else {
            self.response = nil
            return
        }
        self.response = KDBaseResponse<T>(from: data)
    }
}

public extension BaseResponseError {
    var updatedFriendlyMessage: FriendlyMessage? {
        return FriendlyMessage(
            title: response?.friendlyMessage?.title,
            message: response?.friendlyMessage?.message
        )
    }
}
