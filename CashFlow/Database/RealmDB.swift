//
//  RealmDB.swift
//  CashFlow
//
//  Created by Jader Nunes on 2024-02-26.
//

import Foundation
import RealmSwift

protocol DBConformable: Object, Encodable {
    func getPrimaryKey() -> String
}

protocol IDatabase {
    func save<T: DBConformable>(_ data: T) async throws
    func loadAll<T: DBConformable, R: Decodable>(databaseType: T.Type, resultType: R.Type) async throws -> [R]
    func delete(className: String, primaryKey: String) async throws
}

struct RealmDB {

    // MARK: - Attributes

    private let realmQueue = DispatchQueue(label: "realmQueue")
    private let configuration: Realm.Configuration = {
        Realm.Configuration(deleteRealmIfMigrationNeeded: true, objectTypes: [CashFlowRealm.self])
    }()
}

extension RealmDB: IDatabase {
    
    // MARK: - Public methods
    
    func save<T: DBConformable>(_ data: T) async throws {
        try await withCheckedThrowingContinuation { continuation in
            realmQueue.async {
                do {
                    let realm = try Realm(configuration: configuration, queue: realmQueue)
                    try realm.write {
                        realm.add(data)
                        realm.refresh()
                    }
                    
                    sendStatus(continuation, value: .success(Void()))
                } catch {
                    sendStatus(continuation, value: .failure(ErrorRequest.generic()))
                }
            }
        }
    }
    
    func loadAll<T: DBConformable, R: Decodable>(databaseType: T.Type, resultType: R.Type) async throws -> [R] {
        try await withCheckedThrowingContinuation { continuation in
            realmQueue.async {
                do {
                    let realm = try Realm(configuration: configuration, queue: realmQueue)
                    let array = realm.objects(databaseType).array
                    let result = try array.compactMap {
                        try $0.toData()?.decoded(as: resultType)
                    }
                    
                    sendStatus(continuation, value: .success(result))
                } catch {
                    sendStatus(continuation, value: .failure(ErrorRequest.generic()))
                }
            }
        }
    }
    
    func delete(className: String, primaryKey: String) async throws {
        try await withCheckedThrowingContinuation { continuation in
            realmQueue.async {
                do {
                    let realm = try Realm(configuration: configuration, queue: realmQueue)
                    if let toDelete = realm.dynamicObject(ofType: className, forPrimaryKey: primaryKey) {
                        try realm.write {
                            realm.delete(toDelete)
                            realm.refresh()
                        }
                        
                        sendStatus(continuation, value: .success(Void()))
                        return
                    }
                    
                    sendStatus(continuation, value: .failure(ErrorRequest.generic()))
                } catch {
                    sendStatus(continuation, value: .failure(ErrorRequest.generic()))
                }
            }
        }
    }
    
    // MARK: - Private methods
    
    private func sendStatus<T: Any>(_ continuation: CheckedContinuation<T, Error>, value: Result<T, Error>) {
        DispatchQueue.main.async {
            continuation.resume(with: value)
        }
    }
}

// MARK: - Results

private extension Results {
    var array: [Element] { map { $0 } }
}
