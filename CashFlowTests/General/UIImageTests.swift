//
//  UIImageTests.swift
//  CashFlowTests
//
//  Created by Jader Nunes on 09/05/22.
//

import XCTest
@testable import CashFlow

final class UIImageTests: XCTestCase {

    func testIcons() {
        XCTAssertNotNil(UIImage.iconError)
        XCTAssertNotNil(UIImage.iconDollar)
        XCTAssertNotNil(UIImage.iconNoData)
        XCTAssertNotNil(UIImage.iconPlus)
        XCTAssertNotNil(UIImage.iconClose)
        XCTAssertNotNil(UIImage.iconUp)
        XCTAssertNotNil(UIImage.iconDown)
    }
}
