//
//  UITableViewTests.swift
//  CashFlowTests
//
//  Created by Jader Nunes on 09/05/22.
//

import Foundation

import XCTest
@testable import CashFlow

final class UITableViewTests: XCTestCase {

    func testRegisterCells() {
        let table = UITableView()
        table.registerCell(type: RegisterCell.self)
        let cell = table.dequeueReusableCell(with: RegisterCell.self, for: IndexPath())
        XCTAssertNotNil(cell)
    }

    func testRegisterSections() {
        let table = UITableView()
        table.registerHeader(type: RegisterSection.self)
        let cell = table.dequeueReusableHeaderFooterView(with: RegisterSection.self)
        XCTAssertNotNil(cell)
    }
}
