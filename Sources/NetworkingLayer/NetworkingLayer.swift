//
//  NetworkingLayer.swift
//  NetworkingLayer
//
//  Created by T. Fernandez on 19/05/2022.
//  Copyright (c) 2022 Tommy Fernandez. All rights reserved.
//


public struct NetworkingLayer {
    static public func enableLogs() {
        #if DEBUG
        isLogEnabled = true
        #endif
    }
}
