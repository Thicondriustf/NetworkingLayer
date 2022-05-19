//
//  NetworkResponse.swift
//  tricot
//
//  Created by GEOKS on 16/07/2020.
//  Copyright (c) 2020 DIJI. All rights reserved.
//

import Foundation

// This file must not be modified as it is part of the networking layer.
public enum NetworkResponse {
    case success(JSON)
    case failure(NetworkError)
}

public enum NetworkError {
    case networkMissing
    case timedOut
    case responseError(message: String?, code: Int)
    case jsonError(json: JSON)
    case unjsonable
    case undecodable
    case unknown
    case cancelled
}
