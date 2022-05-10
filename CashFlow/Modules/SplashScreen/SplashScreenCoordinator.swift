//
//  SplashScreenCoordinator.swift
//  CashFlow
//
//  Created by Jader Nunes on 09/05/22.
//

import UIKit

protocol SplashScreenCoordinatorDelegate: AnyObject {
    func didFinishSplashScreen()
}

protocol SplashScreenCoordinatorProtocol {
    func openMainApp()
}

final class SplashScreenCoordinator: SplashScreenCoordinatorProtocol {

    // MARK: - Attributes

    private weak var presenter: UIWindow?
    weak var delegate: SplashScreenCoordinatorDelegate?

    // MARK: - Life cycle

    init(presenter: UIWindow) {
        self.presenter = presenter
    }

    // MARK: - Custom methods

    func start() {
        let viewModel = SplashScreenViewModel(coordinator: self)
        let viewController = SplashScreenViewController(viewModel: viewModel)
        presenter?.rootViewController = viewController
        presenter?.makeKeyAndVisible()
    }

    func openMainApp() {
        delegate?.didFinishSplashScreen()
    }
}
