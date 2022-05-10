//
//  Int+Extension.swift
//  CashFlow
//
//  Created by Jader Nunes on 07/05/22.
//

import Foundation

extension Int {

    func toCurrency() -> String {
        let amount = Double(self) * 0.01
        return NumberFormatter.baseFormatter.string(from: NSNumber(value: amount)) ?? ""
    }
}
