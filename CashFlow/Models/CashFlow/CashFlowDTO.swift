//
//  CashFlowDTO.swift
//  CashFlow
//
//  Created by Jader Nunes on 2024-02-26.
//

import Foundation

protocol ICashFlowDTO: Decodable {
    var date: Date { get }
    var desc: String { get }
    var amount: Int { get }
    var type: TypeRegisterDTO { get }
    
    var asRealm: ICashFlowDatabase { get }
    var asDomain: ICashFlowData { get }
    
    init(data: ICashFlowData)
}

struct CashFlowDTO: ICashFlowDTO {
    
    // MARK: - Properties
    
    let date: Date
    let desc: String
    let amount: Int
    let type: TypeRegisterDTO
    
    // MARK: - Life cycle
    
    init(data: ICashFlowData) {
        self.date = data.date
        self.desc = data.desc
        self.amount = data.amount
        self.type = Self.converType(data.type)
    }
    
    // MARK: - Methods
    
    private static func converType(_ type: TypeRegisterData) -> TypeRegisterDTO {
        switch type {
        case .expense:
            return .expense
        case .income:
            return .income
        }
    }
}

// MARK: - Conversion to DTOs & Database

extension CashFlowDTO {
    
    var asRealm: ICashFlowDatabase {
        CashFlowRealm(data: self)
    }
    
    var asDomain: ICashFlowData {
        CashFlowData(
            date: date,
            desc: desc,
            amount: amount,
            type: type.asDomain)
    }
}
