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
            return "register.type.expense".localized()
        case .income:
            return "register.type.income".localized()
        }
    }
}
