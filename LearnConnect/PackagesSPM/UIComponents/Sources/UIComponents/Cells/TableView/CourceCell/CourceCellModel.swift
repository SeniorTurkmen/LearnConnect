//
//  CourceCellModel.swift
//  UIComponents
//
//  Created by Mustafa Turkmen on 25.11.2024.
//

import Foundation

public protocol CourceCellDataSource: AnyObject {
    var name: String? { get set }
    var desc: String? { get set }
    var image: String? { get set }
    var id: Int? { get set }
    var isSaved: Bool? { get set }
}

public protocol CourceCellEventSource: AnyObject {
    
}

public protocol CourceCellProtocol: CourceCellDataSource, CourceCellEventSource {
    
}

public final class CourceCellModel: CourceCellProtocol {
    public var name: String?
    public var desc: String?
    public var image: String?
    public var id: Int?
    public var isSaved: Bool?
    
    public init(
        name: String? = nil,
        desc: String? = nil,
        image: String? = nil,
        id: Int? = nil,
        isSaved: Bool? = false
    ) {
        self.name = name
        self.desc = desc
        self.image = image
        self.id = id
        self.isSaved = isSaved
    }
}
