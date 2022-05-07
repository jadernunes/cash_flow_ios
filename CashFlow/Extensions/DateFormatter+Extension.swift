//
//  DateFormatter+Extension.swift
//  CashFlow
//
//  Created by Jader Nunes on 06/05/22.
//

import Foundation

extension DateFormatter {

    static let dateFormatterReveiced: DateFormatter = {
        $0.dateFormat = DateFormatType.send.rawValue //TODO: - handle it correctly if received from server
        return $0
    }(DateFormatter())

    static let dateFormatterShow: DateFormatter = {
        $0.locale = Locale.current
        $0.timeZone = .current
        return $0
    }(DateFormatter())
}
