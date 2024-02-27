//
//  RealmDBMock.swift
//  CashFlowTests
//
//  Created by Jader Nunes on 2024-02-26.
//

@testable import CashFlow
import RealmSwift

final class DatabaseMock<DBModel: ICashFlowDatabase>: IDatabase {
    
    // MARK: - Properties
    
    private var data = [DBModel]()
    
    // MARK: - Methods
    
    func save<T: DBConformable>(_ data: T) async throws {
        if let object = data as? DBModel {
            self.data.append(object)
        }
    }
    
    func loadAll<T: DBConformable, R: Decodable>(databaseType: T.Type, resultType: R.Type) async throws -> [R] {
        try data.compactMap { try $0.toData()?.decoded(as: resultType) }
    }
    
    func delete(className: String, primaryKey: String) async throws {
        data.removeAll(where: { $0.date == primaryKey })
    }
}
