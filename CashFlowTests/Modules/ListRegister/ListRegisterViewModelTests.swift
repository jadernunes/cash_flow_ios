//
//  ListRegisterViewModelTests.swift
//  CashFlowTests
//
//  Created by Jader Nunes on 09/05/22.
//

import XCTest
@testable import CashFlow

final class ListRegisterViewModelTests: XCTestCase {

    func testListRegisterViewModel() async throws {
        let date = "2024-02-27".toDate(.sendShort) ?? Date()
        let model = CashFlowRealm(data: CashFlowDTO(data: CashFlowData(date: date, desc: "test", amount: 100, type: .income)))
        
        let database = DatabaseMock<CashFlowRealm>()
        try await database.save(model)
        
        let viewModel = ListRegisterViewModel(coordinator: nil,
                                              service: ListRegisterService(database: database))
        
        XCTAssertEqual(viewModel.configuration.value, .idle)

        await viewModel.loadData()

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
            
            let title = date.dayWihSuffix() + " " + date.toString(.show)
            XCTAssertEqual(sectionViewModel?.title, title)
        default:
            XCTFail("\(viewModel.configuration.value)")
        }
    }
}
