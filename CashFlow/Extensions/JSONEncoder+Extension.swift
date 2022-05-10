//
//  JSONEncoder+Extension.swift
//  CashFlow
//
//  Created by Jader Nunes on 06/05/22.
//

import Foundation

extension JSONEncoder {

    static let encoder: JSONEncoder = {
        $0.dateEncodingStrategy = .formatted(.dateFormatterReveiced)
        return $0
    }(JSONEncoder())
}
