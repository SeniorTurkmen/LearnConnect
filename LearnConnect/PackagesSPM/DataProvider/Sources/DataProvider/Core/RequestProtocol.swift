//
//  RequestProtocol.swift
//  DataProvider
//
//  Created by Mustafa Turkmen on 25.11.2024.
//

public protocol RequestProtocol {
    var path: String { get }
    var method: RequestMethod { get }
    var parameters: RequestParameters { get }
    var headers: RequestHeaders { get }
    var encoding: RequestEncoding { get }
    var url: String { get }
}
