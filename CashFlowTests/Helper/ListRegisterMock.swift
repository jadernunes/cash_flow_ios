//
//  ListRegisterMock.swift
//  CashFlowTests
//
//  Created by Jader Nunes on 09/05/22.
//

import Foundation
@testable import CashFlow

final class ListRegisterMock {

    // MARK: - Mock attributes

    var hasSaved = false
    var hasDeleted = false
    var hasLoad = true

    private let data: [DBConformable]

    // MARK: - Life cycle

    init(data: [DBConformable]) {
        self.data = data
    }
}

// MARK: - Database prototol

extension ListRegisterMock: DatabaseProtocol {

    func save<T: DBAcceptable>(_ models: [T], _ completion: @escaping CompletionSaveDelete) {
        hasSaved = true
        completion(.success(Void()))
    }

    func delete<T: DBAcceptable>(_ model: T, _ completion: @escaping CompletionSaveDelete) {
        hasDeleted = true
        completion(.success(Void()))
    }

    func loadAll<T: DBConformable, R: Codable>(typeSaved: T.Type,
                                               typeToReturn: R.Type, _ completion: @escaping CompletionLoad<R>) {
        hasLoad = true
        do {
            let result = try data.map {
                try JSONDecoder.decoder.decode(typeToReturn, from: $0.toJson().toData() ?? Data())
            }
            completion(.success(result))
        } catch {
            completion(.failure(error: .generic()))
        }
    }
}
