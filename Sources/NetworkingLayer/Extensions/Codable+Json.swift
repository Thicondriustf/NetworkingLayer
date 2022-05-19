//
//  Codable+Json.swift
//  tricot
//
//  Created by GEOKS on 17/11/2020.
//  Copyright (c) 2020 TF. All rights reserved.
//

import Foundation

extension Encodable {
    var jsonValue: JSON? {
        guard let data = data else {
            return nil
        }
        
        return data.jsonValue
    }
    
    var data: Data? {
        do {
            return try JSONEncoder().encode(self)
        } catch {
            debug(error)
            return nil
        }
    }
}

extension Decodable {
    static func decode(from json: JSON) -> Self? {
        do {
            let jsonData = try JSONSerialization.data(withJSONObject: json, options: .prettyPrinted)
            return decode(from: jsonData)
        } catch {
            debug(error)
            return nil
        }
    }
    
    static func decode(from data: Data) -> Self? {
        do {
            return try JSONDecoder().decode(self, from: data)
        } catch {
            debug(error)
            return nil
        }
    }
}

extension Data {
    var jsonValue: JSON? {
        do {
            return try JSONSerialization.jsonObject(with: self, options: .allowFragments) as? JSON
        } catch {
            debug(error)
            return nil
        }
    }
}
