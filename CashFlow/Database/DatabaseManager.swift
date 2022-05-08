//
//  DatabaseManager.swift
//  CashFlow
//
//  Created by Jader Nunes on 05/05/22.
//

import Foundation

protocol DatabaseProtocol {
    typealias CompletionSaveDelete = ((Response<Void>) -> Void)
    typealias CompletionLoad<R> = ((Response<[R]>) -> Void)

    func save<T: DBAcceptable>(_ models: [T], _ completion: @escaping CompletionSaveDelete)
    func delete<T: DBAcceptable>(_ model: T, _ completion: @escaping CompletionSaveDelete)
    func loadAll<T: DBConformable, R: Codable>(typeSaved: T.Type,
                                               typeToReturn: R.Type, _ completion: @escaping CompletionLoad<R>)
}

protocol DBAcceptable {
    func realmDTO() -> RealmDTO
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

    func save<T: DBAcceptable>(_ models: [T], _ completion: @escaping CompletionSaveDelete) {
        database.save(models, completion)
    }

    func delete<T: DBAcceptable>(_ model: T, _ completion: @escaping CompletionSaveDelete) {
        database.delete(model, completion)
    }

    func loadAll<T: DBConformable, R: Codable>(typeSaved: T.Type,
                                               typeToReturn: R.Type, _ completion: @escaping CompletionLoad<R>) {
        database.loadAll(typeSaved: typeSaved,
                         typeToReturn: typeToReturn, completion)
    }
}
