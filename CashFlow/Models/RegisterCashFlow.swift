//
//  RegisterCashFlow.swift
//  CashFlow
//
//  Created by Jader Nunes on 05/05/22.
//

import Foundation
import RealmSwift

final class RegisterCashFlow: BaseModel {

    // MARK: - Attributes

    @Persisted var desc: String = ""
    @Persisted var amount: Int = 0
    @Persisted var date: Date = Date()

    // MARK: - Life cycle

    convenience init(id: Int, desc: String, amount: Int, date: Date) {
        self.init()

        self.id = id
        self.desc = desc
        self.amount = amount
        self.date = date
    }
}
