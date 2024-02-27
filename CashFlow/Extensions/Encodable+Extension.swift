//
//  Encodable+Extension.swift
//  CashFlow
//
//  Created by Jader Nunes on 05/05/22.
//

import Foundation

extension Encodable {
    
    func toData(encoder: JSONEncoder = JSONEncoder.encoder) -> Data? {
        do {
            return try encoder.encode(self)
        } catch {
            return nil
        }
    }

    func toJson(encoder: JSONEncoder = JSONEncoder.encoder) -> Dictionary<String, Any> {
        do {
            let jsonData = try encoder.encode(self)
            let json = try JSONSerialization.jsonObject(with: jsonData, options: .allowFragments) as? [String: Any]
            return json ?? [:]
        } catch {
            return [:]
        }
    }
}

extension Dictionary {

    func toData() -> Data? {
        do {
            return try JSONSerialization.data(withJSONObject: self)
        } catch {
            return nil
        }
    }
}
