//
//  CashFlowData.swift
//  CashFlow
//
//  Created by Jader Nunes on 2024-02-26.
//

import Foundation

protocol ICashFlowData {
    var date: Date { get }
    var desc: String { get }
    var amount: Int { get }
    var type: TypeRegisterData { get }
    
    init(date: Date, desc: String, amount: Int, type: TypeRegisterData)
}

struct CashFlowData: ICashFlowData {
    
    // MARK: - Properties
    
    let date: Date
    let desc: String
    let amount: Int
    let type: TypeRegisterData
    
    // MARK: - Life cycle
    
    init() {
        self.date = Date()
        self.desc = ""
        self.amount = 0
        self.type = .income
    }

    init(date: Date, desc: String, amount: Int, type: TypeRegisterData) {
        self.date = date
        self.desc = desc
        self.amount = amount
        self.type = type
    }
}
