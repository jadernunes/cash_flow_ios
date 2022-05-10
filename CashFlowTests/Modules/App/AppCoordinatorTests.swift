//
//  AppCoordinatorTests.swift
//  CashFlowTests
//
//  Created by Jader Nunes on 09/05/22.
//

import XCTest
@testable import CashFlow

final class AppCoordinatorTests: XCTestCase {

    func testAppCoordinatorDefaultFlow() {
        let window = UIWindow()
        let coordinator = AppCoordinator(window: window)
        coordinator.start()
        XCTAssertTrue(window.rootViewController is SplashScreenViewController)
    }

    func testAppCoordinatorListRegister() {
        let window = UIWindow()
        let coordinator = AppCoordinator(window: window, initialFlow: .listRegister)
        coordinator.start()

        let navigation = window.rootViewController as? UINavigationController
        XCTAssertTrue(navigation?.visibleViewController is ListRegisterViewController)
    }
}
