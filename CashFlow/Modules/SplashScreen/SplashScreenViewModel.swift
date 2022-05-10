//
//  SplashScreenViewModel.swift
//  CashFlow
//
//  Created by Jader Nunes on 09/05/22.
//

protocol SplashScreenViewModelProtocol {
    func openMainApp()
}

final class SplashScreenViewModel: SplashScreenViewModelProtocol {

    // MARK: - Attributes

    private let coordinator: SplashScreenCoordinatorProtocol?

    // MARK: - Life cycle

    init(coordinator: SplashScreenCoordinatorProtocol? = nil) {
        self.coordinator = coordinator
    }

    // MARK: - Custom methods

    func openMainApp() {
        coordinator?.openMainApp()
    }
}
