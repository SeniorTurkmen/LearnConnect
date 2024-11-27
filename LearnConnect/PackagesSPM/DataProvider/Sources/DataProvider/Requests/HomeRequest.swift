//
//  HomeRequest.swift
//  DataProvider
//
//  Created by Mustafa Turkmen on 25.11.2024.
//

public struct HomeRequest: SupabaseClient {
    
    public typealias ResponseType = [CourseResponse]
    
    public var path: String = "courses"
    public var method: RequestMethod = .get
    public var parameters: RequestParameters = [:]
    
    public init() {}
    
}
