//
//  ProviderProtocol.swift
//  tricot
//
//  Created by GEOKS on 17/11/2020.
//  Copyright (c) 2020 TF. All rights reserved.
//

import Foundation

// This file must not be modified as it is part of the networking layer.
protocol ProviderProtocol {
    func request(service: ServiceProtocol, completion: @escaping (NetworkResponse) -> ())
}
