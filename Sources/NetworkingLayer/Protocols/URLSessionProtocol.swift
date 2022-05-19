//
//  URLSessionProtocol.swift
//  tricot
//
//  Created by GEOKS on 17/11/2020.
//  Copyright (c) 2020 TF. All rights reserved.
//

import Foundation

// This file must not be modified as it is part of the networking layer.
public protocol URLSessionProtocol {
    typealias DataTaskResult = (Data?, URLResponse?, Error?) -> ()
    func dataTask(request: URLRequest, completionHandler: @escaping DataTaskResult) -> URLSessionDataTask
}

extension URLSession: URLSessionProtocol {
    public func dataTask(request: URLRequest, completionHandler: @escaping DataTaskResult) -> URLSessionDataTask {
        return dataTask(with: request, completionHandler: completionHandler)
    }
}
