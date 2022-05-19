//
//  URLComponents+ServiceProtocol.swift
//  tricot
//
//  Created by GEOKS on 17/11/2020.
//  Copyright (c) 2020 TF. All rights reserved.
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
