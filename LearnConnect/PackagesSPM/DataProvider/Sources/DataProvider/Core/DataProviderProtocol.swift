//
//  DataProviderProtocol.swift
//  DataProvider
//
//  Created by Mustafa Turkmen on 25.11.2024.
//

import UIKit

public typealias DataProviderResult<T: Decodable> = ((Result<T, BaseResponseError<T>>) -> Void)

public protocol DataProviderProtocol {
    func request<T: DecodableResponseRequest>(
        for request: T,
        result: DataProviderResult<T.ResponseType>?
    )
    func uploadRequest<T: DecodableResponseRequest>(
        for request: T,
        files: [MultiPartFileData],
        result: DataProviderResult<T.ResponseType>?
    )
    func downloadRequest<T: DecodableResponseRequest>(
        for request: T,
        result: DataProviderResult<Data>?
    )
}

public extension DataProviderProtocol {
    func uploadRequest<T: DecodableResponseRequest>(
        for request: T,
        files: [MultiPartFileData],
        result: DataProviderResult<T.ResponseType>?
    ) {}
    func downloadRequest<T: DecodableResponseRequest>(
        for request: T,
        result: DataProviderResult<Data>?
    ) {}
}
