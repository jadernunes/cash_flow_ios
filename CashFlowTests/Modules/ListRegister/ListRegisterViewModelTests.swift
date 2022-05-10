//
//  ListRegisterViewModelTests.swift
//  CashFlowTests
//
//  Created by Jader Nunes on 09/05/22.
//

import XCTest
@testable import CashFlow

final class ListRegisterViewModelTests: XCTestCase {

    func testListRegisterViewModel() {
        let model = RegisterCashFlowDTO(value: ["desc": "d",
                                                "amount": 100,
                                                "dateDB": "2022-05-9 10:10:10",
                                                "type": TypeRegister.income.rawValue])

        let viewModel = ListRegisterViewModel(coordinator: nil,
                                              database: DatabaseManager(database: ListRegisterMock(data: [model])))
        XCTAssertEqual(viewModel.configuration.value, .idle)

        viewModel.loadData()

        switch viewModel.configuration.value {
        case .content(let viewModel, let viewModelTotals):
            XCTAssertGreaterThan(viewModel.countSections(), 0)
            XCTAssertEqual(viewModelTotals.balance.value.onlyDigits(), "100")
            XCTAssertEqual(viewModelTotals.expenses.value.onlyDigits(), "000")
            XCTAssertEqual(viewModelTotals.incomes.value.onlyDigits(), "100")

            viewModelTotals.reset()
            XCTAssertEqual(viewModelTotals.balance.value.onlyDigits(), "000")
            XCTAssertEqual(viewModelTotals.expenses.value.onlyDigits(), "000")
            XCTAssertEqual(viewModelTotals.incomes.value.onlyDigits(), "000")

            let sectionViewModel = viewModel.viewModelSectionAt(index: 0)
            XCTAssertEqual(sectionViewModel?.title, "9th May, 2022")
        default:
            XCTFail()
        }
    }
}
