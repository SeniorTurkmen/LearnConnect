//
//  AddCourseRequest.swift
//  DataProvider
//
//  Created by Mustafa Turkmen on 25.11.2024.
//

public struct AddCourseRequest: SupabaseClient {
    
    public typealias ResponseType = String
    
    public var path: String = "users"
    public var method: RequestMethod = .patch
    public var parameters: RequestParameters = [:]
    public var encoding: RequestEncoding = .json
    
    public init(id: String, ids: [Int]) {
        guard let encodedId = id.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed) else { return }
        path = "users?userid=eq.\(encodedId)"
        parameters["courses"] = ids
    }
}
