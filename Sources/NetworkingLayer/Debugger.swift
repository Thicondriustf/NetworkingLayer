//
//  Debugger.swift
//  NetworkingLayer
//
//  Created by T. Fernandez on 19/05/2022.
//  Copyright (c) 2022 Tommy Fernandez. All rights reserved.
//

import UIKit

// DO NOT ADD ANY COMPILABLE METHOD IN THERE !!!!
// The only purpose of this file is to log any information in Debug environment
// This file does not compile in Release and then does not exist in Release Build

#if DEBUG
var isLogEnabled = false
#endif

func debug(service: ServiceProtocol, with networkReponse: NetworkResponse) {
    #if DEBUG
    debug(service.method.rawValue + " " + service.absolutePath, name: "URL")
    
    if let headers = service.headers {
        debug(headers, name: "Headers")
    }
    
    if let params = service.params {
        debug(params, name: "Parameters")
    }
    
    switch networkReponse {
    case .success(let data):
        if let json = data.jsonValue {
            debug(json, name: "Result")
        } else {
            debug(String(data: data, encoding: .utf8), name: "Result")
        }
    case .failure(let error):
        debug(error, name: "Error")
    }
    #endif
}

func debug(_ object: Any?, name: String? = nil) {
    #if DEBUG
    guard isLogEnabled else {
        return
    }
    
    if let object = object, let name = name {
        print("[NetworkingLayer] \(name) : \(object as AnyObject)")
    } else if let name = name {
        print("[NetworkingLayer] \(name) : null")
    } else if let object = object {
        print("[NetworkingLayer] \(object as AnyObject)")
    }
    #endif
}

func debug(_ error: Error) {
    #if DEBUG
    debug(error.localizedDescription, name: "Error")
    #endif
}
