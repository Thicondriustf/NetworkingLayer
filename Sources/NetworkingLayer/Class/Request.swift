//
//  File.swift
//  
//
//  Created by admin on 19/05/2022.
//

import Foundation

public struct Request: ServiceProtocol {
    public init(baseURL: URL, method: HTTPMethod, path: String = "") {
        self.baseURL = baseURL
        self.method = method
        self.path = path
    }
    
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
