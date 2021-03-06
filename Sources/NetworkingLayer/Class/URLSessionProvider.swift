//
//  URLSessionProvider.swift
//  NetworkingLayer
//
//  Created by T. Fernandez on 19/05/2022.
//  Copyright (c) 2022 Tommy Fernandez. All rights reserved.
//

import Foundation

// This file must not be modified ! The file is part of the networking layer so if you need to make some changes or improvements,
// I recommand to write your own networking layer.
public class URLSessionProvider: ProviderProtocol {
    private var session: URLSessionProtocol
    
    public init(session: URLSessionProtocol = URLSession.shared) {
        self.session = session
    }
    
    public func request(service: ServiceProtocol, completion: @escaping (NetworkResponse) -> ()) {
        let request = URLRequest(service: service)
        let task = session.dataTask(request: request, completionHandler: { data, response, error in
            let httpResponse = response as? HTTPURLResponse
            let networkResponse = self.handleDataResponse(data: data, response: httpResponse, error: error)
            debug(service: service, with: networkResponse)
            
            DispatchQueue.main.async {
                completion(networkResponse)
            }
        })
        task.resume()
    }

    public func getAllTasks(completion: @escaping ([URLSessionTask]) -> Void) {
        if let session = session as? URLSession {
            session.getAllTasks(completionHandler: completion)
        }
    }
    
    private func handleDataResponse(data: Data?, response: HTTPURLResponse?, error: Error?) -> NetworkResponse {
        var networkResponse: NetworkResponse
        if let error = error {
            if error._code == NSURLErrorNotConnectedToInternet {
                networkResponse = .failure(.networkMissing)
            } else if error._code == NSURLErrorCancelled {
                networkResponse = .failure(.cancelled)
            } else if error._code == NSURLErrorTimedOut {
                networkResponse = .failure(.timedOut)
            } else {
                networkResponse = .failure(.unknown)
            }
            
            return networkResponse
        }
        
        guard let response = response else {
            return .failure(.unknown)
        }
        
        switch response.statusCode {
        case 200...299:
            guard let data = data else {
                return .failure(.unknown)
            }
            
            networkResponse = .success(data)
        default:
            networkResponse = .failure(.responseError(message: nil, code: response.statusCode))
            
            if let data = data {
                if let json = data.jsonValue as? JSON {
                    networkResponse = .failure(.jsonError(json: json))
                } else if let message = String(data: data, encoding: .utf8) {
                    networkResponse = .failure(.responseError(message: message, code: response.statusCode))
                }
            }
        }
        
        return networkResponse
    }
}
