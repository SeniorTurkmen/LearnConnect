//
//  DecodableResponseRequest.swift
//  DataProvider
//
//  Created by Mustafa Turkmen on 25.11.2024.
//

public protocol DecodableResponseRequest: RequestProtocol {
    associatedtype ResponseType: Decodable
}
