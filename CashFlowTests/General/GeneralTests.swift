//
//  GeneralTests.swift
//  CashFlowTests
//
//  Created by Jader Nunes on 09/05/22.
//

import XCTest
@testable import CashFlow

final class GeneralTests: XCTestCase {

    func testSceneDelegateData() {
        let appDelegate = SceneDelegate(window: UIWindow())
        XCTAssertNotNil(appDelegate.window)
    }

    func testClassObject() {
        class Object: NSObject {}
        let ref = Object()
        XCTAssertEqual(ref.className, "Object")
    }

    func testErrorRequest() {
        var error: ErrorRequest = .custom(message: "custom")
        XCTAssertEqual(error.message, "custom")

        error = .generic(message: "generic")
        XCTAssertEqual(error.message, "generic")
    }

    func testInitView() {
        let view: UIView = initElement()
        XCTAssertFalse(view.translatesAutoresizingMaskIntoConstraints)
    }

    func testCellData() {
        let data = CashFlowData(date: "2022-05-09 10:10:10".toDate(.send) ?? Date(),
                                desc: "q",
                                amount: 100,
                                type: .income)
        let viewModel = RegisterCellViewModel(register: data)
        let model = CellData(viewModel: viewModel, hasCorner: false)
        
        XCTAssertEqual(model.viewModel?.amount, viewModel.amount)
        XCTAssertEqual(model.viewModel?.desc, viewModel.desc)
    }

    func testRegisterCashFlow() {
        let dateString = "2022-05-09 10:10:10"
        let date = dateString.toDate(.send) ?? Date()
        let model = CashFlowData(date: date,
                                 desc: "q",
                                 amount: 100,
                                 type: .income)
        XCTAssertEqual(model.date, date)
        
        let realm = CashFlowDTO(data: model).asRealm
        XCTAssertEqual(realm.getPrimaryKey(), dateString)
    }

    func testIsNotEmpty() {
        XCTAssertTrue([1].isNotEmpty)
        XCTAssertFalse([].isNotEmpty)
    }

    func testDateSuffix() {
        let date1 = "2022-05-1".toDate(.sendShort) ?? Date()
        XCTAssertEqual(date1.dayWihSuffix(), "1st")

        let date21 = "2022-05-21".toDate(.sendShort) ?? Date()
        XCTAssertEqual(date21.dayWihSuffix(), "21st")

        let date31 = "2022-05-31".toDate(.sendShort) ?? Date()
        XCTAssertEqual(date31.dayWihSuffix(), "31st")

        let date02 = "2022-05-02".toDate(.sendShort) ?? Date()
        XCTAssertEqual(date02.dayWihSuffix(), "2nd")

        let date22 = "2022-05-22".toDate(.sendShort) ?? Date()
        XCTAssertEqual(date22.dayWihSuffix(), "22nd")

        let date03 = "2022-05-03".toDate(.sendShort) ?? Date()
        XCTAssertEqual(date03.dayWihSuffix(), "3rd")

        let date23 = "2022-05-23".toDate(.sendShort) ?? Date()
        XCTAssertEqual(date23.dayWihSuffix(), "23rd")

        let date15 = "2022-05-15".toDate(.sendShort) ?? Date()
        XCTAssertEqual(date15.dayWihSuffix(), "15th")
    }
}
