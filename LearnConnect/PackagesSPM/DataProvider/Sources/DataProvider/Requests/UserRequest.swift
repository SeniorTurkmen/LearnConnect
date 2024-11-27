//
//  UserRequest.swift
//  DataProvider
//
//  Created by Mustafa Turkmen on 25.11.2024.
//

public struct UserRequest: SupabaseClient {
    
    public typealias ResponseType = UserResponse
    
    public var path: String = "users"
    public var method: RequestMethod = .post
    public var parameters: RequestParameters = [:]
    
    public init(id: String) {
        parameters["userid"] = id
    }
    
}
