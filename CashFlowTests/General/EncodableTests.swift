//
//  EncodableTests.swift
//  CashFlowTests
//
//  Created by Jader Nunes on 09/05/22.
//

import XCTest
@testable import CashFlow

final class EncodableTests: XCTestCase {
    
    func testEncodableToJson() {
        let key = "name"
        let name = "a"
        struct Test: Codable {
            let name: String
        }

        let model = Test(name: name)
        let json = model.toJson()
        XCTAssertEqual(json.keys.first, key)

        let value = json[key] as? String
        XCTAssertEqual(value, name)
    }

    func testDictionaryConversion() {
        struct Test: Codable {
            let name: String
        }

        let model = Test(name: "a")
        XCTAssertNotNil(model.toJson().toData())
    }
}
