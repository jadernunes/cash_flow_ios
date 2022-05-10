//
//  UIColorTests.swift
//  CashFlowTests
//
//  Created by Jader Nunes on 09/05/22.
//

import XCTest
@testable import CashFlow

final class UIColorTests: XCTestCase {

    func testColors() {
        XCTAssertNotNil(UIColor.clBeige)
        XCTAssertNotNil(UIColor.clBeigeDark)
        XCTAssertNotNil(UIColor.clRedLight)
    }
}
