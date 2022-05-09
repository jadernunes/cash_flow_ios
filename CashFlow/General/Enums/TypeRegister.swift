//
//  TypeRegister.swift
//  CashFlow
//
//  Created by Jader Nunes on 07/05/22.
//

import Foundation

enum TypeRegister: String, Codable, CaseIterable {
    case expense, income

    func title() -> String {
        switch self {
        case .expense:
            return R.string.localizable.registerTypeExpense()
        case .income:
            return R.string.localizable.registerTypeIncome()
        }
    }
}
