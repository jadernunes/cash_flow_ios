//
//  RegisterCashFlow.swift
//  CashFlow
//
//  Created by Jader Nunes on 05/05/22.
//

import Foundation

final class RegisterCashFlow: NSObject, DBAcceptable, Codable {

    // MARK: - Attributes

    private var dateDB: String
    var desc: String
    var amount: Int

    var date: Date? {
      dateDB.toDate(.send)
    }

    init(desc: String, amount: Int, date: Date) {
      self.dateDB = date.toString(.send)
      self.desc = desc
      self.amount = amount
    }
}

// MARK: - Realm conformable

extension RegisterCashFlow {

    func realmDTO() -> RealmDTO {
        RegisterCashFlowDTO(value: toJson())
    }
}
