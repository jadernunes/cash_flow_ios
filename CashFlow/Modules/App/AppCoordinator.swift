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

    init(window: UIWindow?, initialFlow: InitialFlow = .splashScreen) {
        self.window = window
        self.initialFlow = initialFlow
    }

    // MARK: - Attributes

    func start() {
        switch initialFlow {
        case .splashScreen:
            openSplashScreen()
        case .listRegister:
            openListRegister()
        }
    }

    // MARK: - Navigations

    private func openSplashScreen() {
        guard let window = window else { return }
        let coodinator = SplashScreenCoordinator(presenter: window)
        coodinator.delegate = self
        coodinator.start()
    }

    private func openListRegister() {
        let navigation = UINavigationController()
        let coodinator = ListRegisterCoordinator(presenter: navigation)
        coodinator.start()

        window?.rootViewController = navigation
        window?.makeKeyAndVisible()
    }
}

// MARK: - SplashScreen delegate

extension AppCoordinator: SplashScreenCoordinatorDelegate {

    func didFinishSplashScreen() {
        openListRegister()
    }
}
