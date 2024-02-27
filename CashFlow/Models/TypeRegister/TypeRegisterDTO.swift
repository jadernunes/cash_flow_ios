//
//  TypeRegisterDTO.swift
//  CashFlow
//
//  Created by Jader Nunes on 2024-02-26.
//

enum TypeRegisterDTO: String, Decodable {
    case expense, income
}

extension TypeRegisterDTO {
    var asDomain: TypeRegisterData {
        switch self {
        case .expense:
            return .expense
        case .income:
            return .income
        }
    }
}
