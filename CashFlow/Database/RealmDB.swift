//
//  RealmDB.swift
//  CashFlow
//
//  Created by Jader Nunes on 05/05/22.
//

import Foundation
import RealmSwift

typealias RealmDTO = DBConformable
protocol DBConformable: Object, Codable {
    func getPrimaryKey() -> String
}

struct RealmDB {

    // MARK: - Attributes

    private let queue = DispatchQueue(label: "queueRealm")
    private let configuration: Realm.Configuration = {
        Realm.Configuration(deleteRealmIfMigrationNeeded: true, objectTypes: [RegisterCashFlowDTO.self])
    }()
}

// MARK: - Database protocol

extension RealmDB: DatabaseProtocol {

    func save<T: DBAcceptable>(_ models: [T], _ completion: @escaping CompletionSaveDelete) {
        queue.async {
            do {
                let realm = try Realm(configuration: configuration, queue: queue)
                try realm.write {
                    realm.add(models.map { $0.realmDTO() })
                    realm.refresh()
                }
                completion(.success(Void()))
            } catch {
                completion(.failure(error: .generic()))
            }
        }
    }

    func loadAll<T: DBConformable, R: Codable>(typeSaved: T.Type,
                                               typeToReturn: R.Type, _ completion: @escaping CompletionLoad<R>) {
        queue.async {
            do {
                let realm = try Realm(configuration: configuration, queue: queue)
                let array = realm.objects(typeSaved).array
                let result = try array.map {
                    try JSONDecoder.decoder.decode(typeToReturn, from: $0.toJson().toData() ?? Data())
                }

                completion(.success(result))
            } catch {
                completion(.failure(error: .generic()))
            }
        }
    }

    func delete<T: DBAcceptable>(_ model: T, _ completion: @escaping CompletionSaveDelete) {
        let modelDTO = model.realmDTO()
        queue.async {
            do {
                let realm = try Realm(configuration: configuration, queue: queue)
                if let toDelete = realm.dynamicObject(ofType: modelDTO.className, forPrimaryKey: modelDTO.getPrimaryKey()) {
                    try realm.write {
                        realm.delete(toDelete)
                        realm.refresh()
                    }
                    completion(.success(Void()))
                } else {
                    completion(.failure(error: .generic()))
                }
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
