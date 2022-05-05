//
//  AppCoordinator.swift
//  CashFlow
//
//  Created by Jader Nunes on 05/05/22.
//

import UIKit

final class AppCoordinator {

    // MARK: - Attributes

    private let window: UIWindow?
    private let initialFlow: InitialFlow

    // MARK: - Life cycle

    init(window: UIWindow?, initialFlow: InitialFlow = .listRegister) {
        self.window = window
        self.initialFlow = initialFlow
    }

    // MARK: - Attributes

    func start() {
        switch initialFlow {
        case .listRegister:
            openListRegister()
        }
    }

    // MARK: - Navigations

    private func openListRegister() {
        let navigation = UINavigationController()
        let coodinator = ListRegisterCoordinator(presenter: navigation)
        coodinator.start()

        window?.rootViewController = navigation
        window?.makeKeyAndVisible()
    }
}
