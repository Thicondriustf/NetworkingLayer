//
//  File.swift
//  
//
//  Created by admin on 19/05/2022.
//

import Foundation

public struct Request: ServiceProtocol {
    public var baseURL: URL
    public var method: HTTPMethod
    public var path: String = ""
    
    public var absolutePath: String {
        return baseURL.absoluteString + path
    }
    
    public var params: JSON? {
        return nil
    }
    
    public var headers: HTTPHeaders? {
        return nil
    }
    
    public var uploadImages: [HTTPImage] {
        return []
    }
}

struct ComplicatedRequest: ServiceProtocol {
    var baseURL: URL
    var path: String
    var method: HTTPMethod
    var params: JSON?
    var headers: HTTPHeaders?
    var uploadImages: [HTTPImage]
}

enum Requests: ServiceProtocol {
    case requestOne
    case requestTwo(variable: String)
    
    var baseURL: URL {
        return URL(string: "your base url")!
    }
    
    var path: String {
        switch self {
        case .requestOne:
            return "request/one"
        case .requestTwo(variable: let variable):
            return "request/two/" + variable
        }
    }
    
    var method: HTTPMethod {
        return .get
    }
    
    var params: JSON? {
        return nil
    }
    
    var headers: HTTPHeaders? {
        return nil
    }
    
    var uploadImages: [HTTPImage] {
        return []
    }
}
