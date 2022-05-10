//
//  AddRegisterViewModelTests.swift
//  CashFlowTests
//
//  Created by Jader Nunes on 09/05/22.
//

import XCTest
@testable import CashFlow

final class AddRegisterViewModelTests: XCTestCase {

    func testAddRegisterViewModel() {
        let viewModel = AddRegisterViewModel(coordinator: nil,
                                             database: DatabaseManager(database: ListRegisterMock(data: [])))
        XCTAssertEqual(viewModel.configuration.value, .idle)

        viewModel.didSelectType(.expense)
        viewModel.descDidChange("a")
        viewModel.amountDidChange(100)

        let spy = AddRegisterViewModelSpy()
        viewModel.delegate = spy

        XCTAssertFalse(spy.hasAdded)
        viewModel.save()
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
