//
//  ListRegisterService.swift
//  CashFlow
//
//  Created by Jader Nunes on 2024-02-25.
//

import Foundation

protocol IListRegisterService {
    
    func loadAllData() async throws -> [ICashFlowData]
    func delete(date: Date) async throws
}

struct ListRegisterService: IListRegisterService {
    
    // MARK: - Properties
    
    private let database: IDatabase
    
    // MARK: - Life cycle
    
    init(database: IDatabase = RealmDB()) {
        self.database = database
    }
    
    // MARK: - Methods
    
    func loadAllData() async throws -> [ICashFlowData] {
        try await database
            .loadAll(databaseType: CashFlowRealm.self, resultType: CashFlowDTO.self)
            .compactMap { $0.asDomain }
    }
    
    func delete(date: Date) async throws {
        try await database.delete(className: CashFlowRealm.className, primaryKey: date.toString(.send))
    }
}
