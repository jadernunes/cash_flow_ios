//
//  EnumsTests.swift
//  CashFlowTests
//
//  Created by Jader Nunes on 09/05/22.
//

import XCTest
@testable import CashFlow

final class EnumsTests: XCTestCase {

    func testEnumInitialFlow() {
        let allCases = InitialFlow.allCases
        let enumeratedCases: [InitialFlow] = [.splashScreen, .listRegister]

        XCTAssertEqual(InitialFlow.allCases.count, 2)

        let fistCase = enumeratedCases.first
        XCTAssertEqual(fistCase, .splashScreen)

        allCases.forEach {
            XCTAssertEqual(enumeratedCases.contains($0), true)
        }
    }

    func testDateFormatType() {
        let allCases = DateFormatType.allCases
        let enumeratedCases: [DateFormatType] = [.send, .sendShort, .show]

        XCTAssertEqual(DateFormatType.allCases.count, 3)

        XCTAssertEqual(DateFormatType.sendShort.rawValue, "yyyy-MM-dd")
        XCTAssertEqual(DateFormatType.send.rawValue, "yyyy-MM-dd hh:mm:ss")
        XCTAssertEqual(DateFormatType.show.rawValue, "MMMM, yyyy")

        let fistCase = enumeratedCases.first
        XCTAssertEqual(fistCase, .send)

        allCases.forEach {
            XCTAssertEqual(enumeratedCases.contains($0), true)
        }
    }

    func testTypeRegister() {
        let allCases = TypeRegister.allCases
        let enumeratedCases: [TypeRegister] = [.expense, .income]

        XCTAssertEqual(TypeRegister.allCases.count, 2)

        let fistCase = enumeratedCases.first
        XCTAssertEqual(fistCase, .expense)

        allCases.forEach {
            XCTAssertEqual(enumeratedCases.contains($0), true)
        }
    }

    func testBorderSide() {
        let allCases = BorderSide.allCases
        let enumeratedCases: [BorderSide] = [.left, .right, .top, .bottom]

        XCTAssertEqual(BorderSide.allCases.count, 4)

        let fistCase = enumeratedCases.first
        XCTAssertEqual(fistCase, .left)

        allCases.forEach {
            XCTAssertEqual(enumeratedCases.contains($0), true)
        }
    }
}
