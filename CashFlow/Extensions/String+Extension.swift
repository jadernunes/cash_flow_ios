//
//  String+Extension.swift
//  CashFlow
//
//  Created by Jader Nunes on 08/05/22.
//

import Foundation

extension String {

    func toDate(_ format: DateFormatType) -> Date? {
        let formatter = DateFormatter.dateFormatterShow
        formatter.dateFormat = format.rawValue
        return formatter.date(from: self)
    }
}
