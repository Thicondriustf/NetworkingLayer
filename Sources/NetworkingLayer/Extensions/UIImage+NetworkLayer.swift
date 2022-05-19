//
//  UIImage+NetworkingLayer.swift
//  NetworkingLayer
//
//  Created by T. Fernandez on 19/05/2022.
//  Copyright (c) 2022 Tommy Fernandez. All rights reserved.
//

import UIKit

extension UIImage {
    var imageData: Data? {
        return jpegData(compressionQuality: 1)
    }
    
    func compressedData(maximumLength: Int) -> Data? {
        guard var data = imageData else {
            return nil
        }
        
        var compressionTime = 0
        while data.count > maximumLength {
            compressionTime += 1
            data = jpegData(compressionQuality: 1 - 0.1 * CGFloat(compressionTime))!
        }
        
        return data
    }
}
