//
//  TotalsData.swift
//  CashFlow
//
//  Created by Jader Nunes on 07/05/22.
//

import Foundation

struct TotalsData {
    let income: Int
    let expense: Int

    init(income: Int = 0, expense: Int = 0) {
        self.income = income
        self.expense = expense
    }
}
