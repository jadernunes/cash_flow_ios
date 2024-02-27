//
//  AddRegisterViewModelTests.swift
//  CashFlowTests
//
//  Created by Jader Nunes on 09/05/22.
//

import XCTest
@testable import CashFlow

final class AddRegisterViewModelTests: XCTestCase {

    func testAddRegisterViewModel() async throws {
        let date = "2024-02-27".toDate(.sendShort) ?? Date()
        let model = CashFlowRealm(data: CashFlowDTO(data: CashFlowData(date: date, desc: "test", amount: 100, type: .income)))
        
        let database = DatabaseMock<CashFlowRealm>()
        try await database.save(model)
        
        let viewModel = AddRegisterViewModel(coordinator: nil,
                                             service: AddRegisterService(database: database))
        XCTAssertEqual(viewModel.configuration.value, .idle)

        viewModel.didSelectType(.expense)
        viewModel.descDidChange("a")
        viewModel.amountDidChange(100)

        let spy = AddRegisterViewModelSpy()
        viewModel.delegate = spy

        XCTAssertFalse(spy.hasAdded)
        await viewModel.save()
        XCTAssertTrue(spy.hasAdded)

        XCTAssertEqual(viewModel.configuration.value, .loading)
    }
}

private final class AddRegisterViewModelSpy: AddRegisterDelegate {

    // MARK: - Mock attributes

    var hasAdded = false

    // MARK: - AddRegister delegate

    func didAddRegister() {
        hasAdded = true
    }
}
