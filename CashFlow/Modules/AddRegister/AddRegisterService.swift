//
//  AddRegisterService.swift
//  CashFlow
//
//  Created by Jader Nunes on 2024-02-26.
//

protocol IAddRegisterService {
    
    func save(data: ICashFlowData) async throws
}

struct AddRegisterService: IAddRegisterService {
    
    // MARK: - Properties
    
    private let database: IDatabase
    
    // MARK: - Life cycle
    
    init(database: IDatabase = RealmDB()) {
        self.database = database
    }
    
    // MARK: - Methods
    
    func save(data: ICashFlowData) async throws {
        let realmModel = CashFlowDTO(data: data).asRealm
        try await database.save(realmModel)
    }
}
