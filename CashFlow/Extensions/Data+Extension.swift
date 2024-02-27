//
//  Data+Extension.swift
//  CashFlow
//
//  Created by Jader Nunes on 2024-02-26.
//

import Foundation

extension Data {
    func decoded<T: Decodable>(as type: T.Type, using decoder: JSONDecoder = JSONDecoder.decoder) throws -> T {
        try decoder.decode(type, from: self)
    }
}
