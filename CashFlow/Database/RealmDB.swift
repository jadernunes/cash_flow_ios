//
//  RealmDB.swift
//  CashFlow
//
//  Created by Jader Nunes on 05/05/22.
//

import Foundation
import RealmSwift

typealias RealmDTO = Object
protocol DBConformable: Object, Codable {}

struct RealmDB {

    // MARK: - Attributes

    private let queue = DispatchQueue(label: "queueRealm")
    private let configuration: Realm.Configuration = {
        Realm.Configuration(deleteRealmIfMigrationNeeded: true, objectTypes: [RegisterCashFlowDTO.self])
    }()
}

// MARK: - Database protocol

extension RealmDB: DatabaseProtocol {

    func save<T: DBAcceptable>(_ models: [T], _ completion: @escaping CompletionSave) {
        queue.async {
            do {
                let realm = try Realm(configuration: configuration, queue: queue)
                try realm.write {
                    realm.deleteAll()
                    realm.add(models.map { $0.realmDTO() })
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
}

// MARK: - Results

private extension Results {
    var array: [Element] { map { $0 } }
}
