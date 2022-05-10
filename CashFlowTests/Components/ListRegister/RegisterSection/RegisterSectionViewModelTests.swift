//
//  RegisterSectionViewModelTests.swift
//  CashFlowTests
//
//  Created by Jader Nunes on 09/05/22.
//

import XCTest
@testable import CashFlow

final class RegisterSectionViewModelTests: XCTestCase {

    func testRegisterSectionViewModel() {
        let viewModel = RegisterSectionViewModel(date: "2022-05-09 10:10:10".toDate(.send) ?? Date())
        XCTAssertEqual(viewModel.title, "9th May, 2022")
    }
}
