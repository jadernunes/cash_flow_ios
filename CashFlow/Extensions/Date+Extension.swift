//
//  Date+Extension.swift
//  CashFlow
//
//  Created by Jader Nunes on 06/05/22.
//

import Foundation

extension Date {

  func toString(_ format: DateFormatType) -> String {
    let formatter = DateFormatter.dateFormatterShow
    formatter.dateFormat = format.rawValue
    return formatter.string(from: self)
  }
}

extension String {

  func toDate(_ format: DateFormatType) -> Date? {
    let formatter = DateFormatter.dateFormatterShow
    formatter.dateFormat = format.rawValue
    return formatter.date(from: self)
  }
}
