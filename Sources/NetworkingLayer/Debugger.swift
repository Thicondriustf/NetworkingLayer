//
//  Debugger.swift
//  tricot
//
//  Created by GEOKS on 16/07/2020.
//  Copyright (c) 2020 DIJI. All rights reserved.
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
    case .success(let json):
        debug(json, name: "Result")
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
        print(name + " : " + "\(object as AnyObject)")
    } else if let name = name {
        print(name + " : " + "null")
    } else if let object = object {
        print(object as AnyObject)
    } else {
        print("null")
    }
    #endif
}

func debug(_ error: Error) {
    #if DEBUG
    debug(error.localizedDescription, name: "Error")
    #endif
}
