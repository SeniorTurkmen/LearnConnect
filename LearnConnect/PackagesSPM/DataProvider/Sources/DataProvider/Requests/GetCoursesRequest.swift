//
//  GetCoursesRequest.swift
//  DataProvider
//
//  Created by Mustafa Turkmen on 25.11.2024.
//

public struct GetCoursesRequest: SupabaseClient {
    
    public typealias ResponseType = [UserResponse]
    
    public var path: String = ""
    public var method: RequestMethod = .get
    public var parameters: RequestParameters = [:]
    
    public init(id: String) {
        guard let encodedId = id.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed) else { return }
        path = "users?userid=eq.\(encodedId)"
    }
}
