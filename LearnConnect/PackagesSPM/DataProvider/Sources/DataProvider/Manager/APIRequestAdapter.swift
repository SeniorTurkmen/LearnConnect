//
//  APIRequestAdapter.swift
//  DataProvider
//
//  Created by Mustafa Turkmen on 25.11.2024.
//

import Alamofire

struct APIRequestAdapter {
    let method: HTTPMethod
    let parameters: Parameters
    let headers: HTTPHeaders
    let encoding: ParameterEncoding
    let url: String

    init<T: RequestProtocol>(request: T) {
        self.method = request.method.toAlamofireHTTPMethod
        self.parameters = request.parameters
        var headers: HTTPHeaders = [:]
        request.headers.forEach { headers[$0.key] = $0.value }
        self.headers = headers
        self.encoding = request.encoding.toAlamofireEncoding
        self.url = request.url
    }
}

// MARK: - Get Alamofire HTTPMethod
extension RequestMethod {
    var toAlamofireHTTPMethod: HTTPMethod {
        switch self {
        case .connect: return .connect
        case .delete: return .delete
        case .get: return .get
        case .head: return .head
        case .options: return .options
        case .patch: return .patch
        case .post: return .post
        case .put: return .put
        case .trace: return .trace
        }
    }
}

// MARK: - Get Alamofire ParameterEncoding
extension RequestEncoding {
    var toAlamofireEncoding: ParameterEncoding {
        switch self {
        case .json: return JSONEncoding.default
        case .url: return URLEncoding(boolEncoding: .literal)
        }
    }
}
