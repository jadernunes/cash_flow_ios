//
//  DatabaseManager.swift
//  CashFlow
//
//  Created by Jader Nunes on 05/05/22.
//

import Foundation

protocol DatabaseProtocol {
    typealias CompletionDBSave = ((Response<Void>) -> Void)
    typealias CompletionDBLoad<T> = ((Response<[T]>) -> Void)

    func save<T: BaseModel>(_ models: [T], _ completion: @escaping CompletionDBSave)
    func loadAll<T: BaseModel>(type: T.Type, _ completion: @escaping CompletionDBLoad<T>)
}

final class DatabaseManager {

    // MARK: - Attributes

    private var database: DatabaseProtocol

    // MARK: - Life cycle

    init(database: DatabaseProtocol = RealmDB()) {
        self.database = database
    }
}

// MARK: - Database protocol

extension DatabaseManager: DatabaseProtocol {

    func save<T: BaseModel>(_ models: [T], _ completion: @escaping CompletionDBSave) {
        database.save(models, completion)
    }

    func loadAll<T: BaseModel>(type: T.Type, _ completion: @escaping CompletionDBLoad<T>) {
        database.loadAll(type: type, completion)
    }
}
