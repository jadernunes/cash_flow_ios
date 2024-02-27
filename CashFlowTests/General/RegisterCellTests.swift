//
//  RegisterCellTests.swift
//  CashFlowTests
//
//  Created by Jader Nunes on 09/05/22.
//

import XCTest
@testable import CashFlow

final class RegisterCellTests: XCTestCase {

    func testRegisterCellSuccess() {
        let model = CashFlowData(date: Date(), desc: "a", amount: 100, type: .expense)
        let viewModel = RegisterCellViewModel(register: model)

        XCTAssertEqual(viewModel.amount.onlyDigits(), "100")
        XCTAssertEqual(viewModel.desc, "a")
    }
}
