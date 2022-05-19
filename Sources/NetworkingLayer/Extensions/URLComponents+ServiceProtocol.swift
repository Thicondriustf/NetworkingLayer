//
//  URLComponents+ServiceProtocol.swift
//  NetworkingLayer
//
//  Created by T. Fernandez on 19/05/2022.
//  Copyright (c) 2022 Tommy Fernandez. All rights reserved.
//

import Foundation

// This file must not be modified as it is part of the networking layer.
// This extension is responsible for en easy-to-make API calls
extension URLComponents {
    init(service: ServiceProtocol) {
        let url = service.baseURL.appendingPathComponent(service.path)
        self.init(url: url, resolvingAgainstBaseURL: false)!
        
        guard service.method == .get, let params = service.params else {
            return
        }
        
        queryItems = params.map { key, value in
            return URLQueryItem(name: key, value: String(describing: value))
        }
    }
}
