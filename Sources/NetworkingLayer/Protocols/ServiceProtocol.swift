//
//  ServiceProtocol.swift
//  tricot
//
//  Created by GEOKS on 17/11/2020.
//  Copyright (c) 2020 TF. All rights reserved.
//

import Foundation
import UIKit

// This file must not be modified as it is part of the networking layer.
// It implements a protocol that must be used to make API calls easily.

public typealias JSON = [ String : Any ]
public typealias HTTPHeaders = [ String : String ]

public struct HTTPImage {
    var name: String
    var filename: String
    var mimeType: String
    var image: UIImage?
}

public protocol ServiceProtocol {
    var baseURL: URL { get }
    var path: String { get }
    var method: HTTPMethod { get }
    var params: JSON? { get }
    var headers: HTTPHeaders? { get }
    var uploadImages: [HTTPImage] { get }
}

extension ServiceProtocol {
    var absolutePath: String {
        return baseURL.absoluteString + path
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
