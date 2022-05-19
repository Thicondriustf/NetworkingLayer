//
//  Codable+Json.swift
//  tricot
//
//  Created by GEOKS on 17/11/2020.
//  Copyright (c) 2020 TF. All rights reserved.
//

import Foundation

extension Encodable {
    public var data: Data? {
        do {
            return try JSONEncoder().encode(self)
        } catch {
            debug(error)
            return nil
        }
    }
}

extension Decodable {
    public static func decode(from json: JSON) -> Self? {
        do {
            let jsonData = try JSONSerialization.data(withJSONObject: json, options: .prettyPrinted)
            return decode(from: jsonData)
        } catch {
            debug(error)
            return nil
        }
    }
    
    public static func decode(from data: Data) -> Self? {
        do {
            return try JSONDecoder().decode(self, from: data)
        } catch {
            debug(error)
            return nil
        }
    }
}

extension Data {
    var jsonValue: Any? {
        do {
            return try JSONSerialization.jsonObject(with: self, options: .allowFragments)
        } catch {
            debug(error)
            return nil
        }
    }
}
