//
//  RealmDB.swift
//  CashFlow
//
//  Created by Jader Nunes on 05/05/22.
//

import Foundation
import RealmSwift

struct RealmDB {

    // MARK: - Attributes

    private let queueRealm = DispatchQueue(label: "queueRealm")
    private let realmConfiguration: Realm.Configuration = {
        Realm.Configuration(deleteRealmIfMigrationNeeded: true,
                            objectTypes: [RegisterCashFlow.self, BaseModel.self])
    }()
}

// MARK: - Database protocol

extension RealmDB: DatabaseProtocol {

    func save<T: BaseModel>(_ models: [T], _ completion: @escaping CompletionDBSave) {
        queueRealm.async {
            do {
                let realm = try Realm(configuration: self.realmConfiguration, queue: self.queueRealm)
                try realm.write {
                    realm.add(models)
                }
                completion(.success(Void()))
            } catch {
                completion(.failure(error: .generic()))
            }
        }
    }

    func loadAll<T: BaseModel>(type: T.Type, _ completion: @escaping CompletionDBLoad<T>) {
        queueRealm.async {
            do {
                let realm = try Realm(configuration: realmConfiguration, queue: queueRealm)
                let results = realm.objects(type).array
                completion(.success(results))
            } catch {
                completion(.failure(error: .generic()))
            }
        }
    }
}

// MARK: - Results

private extension Results {
    var array: [Element] { map { $0 } }
}
