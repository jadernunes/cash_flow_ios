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

    func onlyDigits() -> String {
        let filtredUnicodeScalars = unicodeScalars.filter { CharacterSet.decimalDigits.contains($0) }
        return String(String.UnicodeScalarView(filtredUnicodeScalars))
    }

    func localized() -> String {
        let textLocalised = NSLocalizedString(self, comment: "")
        return self == textLocalised ? "" : textLocalised
    }
}
