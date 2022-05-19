//
//  NetworkResponse.swift
//  NetworkingLayer
//
//  Created by T. Fernandez on 19/05/2022.
//  Copyright (c) 2022 Tommy Fernandez. All rights reserved.
//

import Foundation

// This file must not be modified as it is part of the networking layer.
public enum NetworkResponse {
    case success(Data)
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
