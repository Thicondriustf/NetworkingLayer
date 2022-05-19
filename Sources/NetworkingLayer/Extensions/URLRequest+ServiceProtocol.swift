//
//  URLRequest+ServiceProtocol.swift
//  NetworkingLayer
//
//  Created by T. Fernandez on 19/05/2022.
//  Copyright (c) 2022 Tommy Fernandez. All rights reserved.
//

import Foundation

// This file must not be modified as it is part of the networking layer.
// This extension is responsible for en easy-to-make API calls
extension URLRequest {
    init(service: ServiceProtocol) {
        let urlComponents = URLComponents(service: service)
        self.init(url: urlComponents.url!)
        httpMethod = service.method.rawValue
        service.headers?.forEach { key, value in
            addValue(value, forHTTPHeaderField: key)
        }
        
        addValue("application/json", forHTTPHeaderField: "Content-Type")
        
        guard service.method != .get, let params = service.params else {
            return
        }
        
        if service.uploadImages.isEmpty {
            httpBody = try? JSONSerialization.data(withJSONObject: params)
        } else {
            let boundary = UUID().uuidString
            var data = Data()
            params.forEach { param in
                data.append(dataBody(value: param.value, for: param.key, with: boundary))
            }
            
            service.uploadImages.forEach { (httpImage) in
                data.append(dataImage(httpImage: httpImage, with: boundary))
            }
            
            data.append("--\(boundary)--\r\n".data(using: .utf8)!)
            httpBody = data
        }
        
        guard let contentLength = httpBody?.count else {
            return
        }
        
        addValue("\(contentLength)", forHTTPHeaderField: "Content-Length")
    }
    
    private func dataBody(value: Any, for key: String, with boundary: String) -> Data {
        var httpBody = "--\(boundary)\r\n"
        httpBody += "Content-Disposition: form-data; name=\"\(key)\"\r\n\r\n"
        httpBody += "\(value)\r\n"
        return httpBody.data(using: .utf8) ?? Data()
    }
    
    private func dataImage(httpImage: HTTPImage, with boundary: String) -> Data {
        guard let image = httpImage.image?.compressedData(maximumLength: 1000000) else {
            return Data()
        }
        
        var httpBody = "--\(boundary)\r\n"
        httpBody += "Content-Disposition: form-data; name=\"\(httpImage.name)\"; filename=\"\(httpImage.filename)\"\r\n"
        httpBody += "Content-Type: \(httpImage.mimeType)\r\n"
        var data = httpBody.data(using: .utf8)
        data?.append(image)
        data?.append("\r\n".data(using: .utf8)!)
        return data ?? Data()
    }
}
