//
//  StringTests.swift
//  CashFlowTests
//
//  Created by Jader Nunes on 09/05/22.
//

import XCTest
@testable import CashFlow

final class StringTests: XCTestCase {

    func testToDate() {
        XCTAssertNotNil("2022-05-09 10:10:10".toDate(.send))
    }

    func testIsOnlyDigit() {
        XCTAssertEqual("-23.4".onlyDigits(), "234")
    }
}
