//
//  CashFlowRealm.swift
//  CashFlow
//
//  Created by Jader Nunes on 2024-02-26.
//

import Foundation
import RealmSwift

protocol ICashFlowDatabase: DBConformable {
    var date: String { get }
    var desc: String { get }
    var amount: Int { get }
    var type: String { get }
}

final class CashFlowRealm: Object, ICashFlowDatabase {

    // MARK: - Attributes
    
    @objc dynamic var desc: String = ""
    @objc dynamic var amount: Int = 0
    @objc dynamic var date: String = ""
    @objc dynamic var type: String = ""
    
    // MARK: - Life cycle
    
    override init() {
        super.init()
    }
    
    init(data: ICashFlowDTO) {
        self.desc = data.desc
        self.amount = data.amount
        self.date = data.date.toString(.send)
        self.type = data.type.rawValue
    }

    override class func primaryKey() -> String? {
        "date"
    }
}

// MARK: - DBConformable

extension CashFlowRealm {
    
    func getPrimaryKey() -> String {
        date
    }
}
