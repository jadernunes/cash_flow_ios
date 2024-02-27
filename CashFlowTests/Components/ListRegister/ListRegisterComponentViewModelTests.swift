//
//  ListRegisterComponentViewModelTests.swift
//  CashFlowTests
//
//  Created by Jader Nunes on 09/05/22.
//

import XCTest
@testable import CashFlow

final class ListRegisterComponentViewModelTests: XCTestCase {

    func testListRegisterComponent() async {
        let date = "2022-05-09 10:10:10".toDate(.send) ?? Date()
        let register = CashFlowData(date: date, desc: "a", amount: 100, type: .income)
        let section = SectionData(date: date,
                                  registers: [register])

        let spy = ListRegisterComponentSpy()
        let viewModel = ListRegisterComponentViewModel(sections: [section])
        viewModel.delegate = spy

        XCTAssertEqual(viewModel.countSections(), 1)
        XCTAssertEqual(viewModel.countRegistersAt(indexSection: 0), 1)

        XCTAssertFalse(spy.hasRemoved)
        await viewModel.remove(index: 0, onIndexSection: 0)
        XCTAssertTrue(spy.hasRemoved)
    }
}

// MARK: - Mock delegate

private final class ListRegisterComponentSpy: ListRegisterDelegate {

    // MARK: - Mock attributes

    var hasRemoved = false

    // MARK: - ListRegister delegate

    func willRemove(_ register: ICashFlowData?) async {
        hasRemoved = true
    }
}
