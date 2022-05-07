//
//  NumberFormatter+Extension.swift
//  CashFlow
//
//  Created by Jader Nunes on 07/05/22.
//

import Foundation

extension NumberFormatter {

    static let baseFormatter: NumberFormatter  = {
        $0.numberStyle = .currency
        $0.roundingMode = .down
        $0.locale = Locale.autoupdatingCurrent
        return $0
    }(NumberFormatter())
}

