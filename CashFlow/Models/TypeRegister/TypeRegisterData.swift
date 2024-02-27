//
//  TypeRegisterData.swift
//  CashFlow
//
//  Created by Jader Nunes on 2024-02-26.
//

enum TypeRegisterData: CaseIterable {
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
