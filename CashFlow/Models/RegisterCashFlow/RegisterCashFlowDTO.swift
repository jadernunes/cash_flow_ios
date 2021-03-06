//
//  RegisterCashFlowDTO.swift
//  CashFlow
//
//  Created by Jader Nunes on 06/05/22.
//

import Foundation
import RealmSwift

final class RegisterCashFlowDTO: Object, DBConformable {

    // MARK: - Attributes
    
    @objc private dynamic var desc: String = ""
    @objc private dynamic var amount: Int = 0
    @objc private dynamic var dateDB: String = ""
    @objc private dynamic var type: String = ""

    override class func primaryKey() -> String? {
        "dateDB"
    }

    func getPrimaryKey() -> String {
        dateDB
    }
}
