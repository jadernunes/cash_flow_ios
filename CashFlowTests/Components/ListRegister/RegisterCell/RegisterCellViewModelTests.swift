//
//  RegisterCellViewModelTests.swift
//  CashFlowTests
//
//  Created by Jader Nunes on 09/05/22.
//

import XCTest
@testable import CashFlow

final class RegisterCellViewModelTests: XCTestCase {

    func testRegisterCellViewModel() {
        let register = RegisterCashFlow(desc: "q",
                         amount: 100,
                         date: "2022-05-09 10:10:10".toDate(.send) ?? Date(),
                         type: .income)
        let viewModel = RegisterCellViewModel(register: register)
        XCTAssertEqual(viewModel.desc, "q")
        XCTAssertEqual(viewModel.amount, "$1.00")
    }
}
