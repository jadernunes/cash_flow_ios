//
//  BaseModel.swift
//  CashFlow
//
//  Created by Jader Nunes on 05/05/22.
//

import RealmSwift

class BaseModel: Object {
    @Persisted(primaryKey: true) var id: Int

    override class func primaryKey() -> String? {
        "id"
    }
}
