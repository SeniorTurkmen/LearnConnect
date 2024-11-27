//
//  APILogger.swift
//  LearnConnect
//
//  Created by Mustafa Turkmen on 25.11.2024.
//

import Alamofire
import Logger
import UIKit

public final class APILogger: EventMonitor {
    static let shared = APILogger()

    public let queue = DispatchQueue(label: "com.case.ios.networklogger")

    public func request(
        _ request: Request,
        didCreateURLRequest urlRequest: URLRequest
    ) {
        Logger().debug(message: "---> Request Created <---")
        Logger().debug(message: request.description)
    }

    public func requestDidFinish(_ request: Request) {
        Logger().debug(message: "---> Request Finished <---")
        Logger().debug(message: request.description)
    }

    public func request<Value>(
        _ request: DataRequest,
        didParseResponse response: DataResponse<Value, AFError>
    ) {
        Logger().debug(message: "---> Request JSONResponse <---")
        if let data = response.data, let json = String(data: data, encoding: .utf8) {
            Logger().debug(message: json)
        }
    }
}
