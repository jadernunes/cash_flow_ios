//
//  TotalsTests.swift
//  CashFlowTests
//
//  Created by Jader Nunes on 09/05/22.
//

import XCTest
@testable import CashFlow

final class TotalsComponentViewModelTests: XCTestCase {

    func testListRegisterComponent() {
        let viewModel = TotalsComponentViewModel(data: TotalsData(income: 200, expense: 100))
        XCTAssertEqual(viewModel.incomes.value.onlyDigits(), "200")
        XCTAssertEqual(viewModel.expenses.value.onlyDigits(), "100")
        XCTAssertEqual(viewModel.balance.value.onlyDigits(), "100")
    }
}
