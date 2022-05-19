//
//  ProviderProtocol.swift
//  NetworkingLayer
//
//  Created by T. Fernandez on 19/05/2022.
//  Copyright (c) 2022 Tommy Fernandez. All rights reserved.
//

import Foundation

// This file must not be modified as it is part of the networking layer.
protocol ProviderProtocol {
    func request(service: ServiceProtocol, completion: @escaping (NetworkResponse) -> ())
}
