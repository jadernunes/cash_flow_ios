//
//  ListRegisterCoordinator.swift
//  CashFlow
//
//  Created by Jader Nunes on 05/05/22.
//

import UIKit

protocol ListRegisterCoordinatorProtocol {
    func openAddRegister()
}

final class ListRegisterCoordinator: ListRegisterCoordinatorProtocol {

    // MARK: - Attributes

    private weak var presenter: UINavigationController?

    // MARK: - Life cycle

    init(presenter: UINavigationController) {
        self.presenter = presenter
    }

    // MARK: - Custom methods

    func start() {
        let viewModel = ListRegisterViewModel(coordinator: self)
        let viewController = ListRegisterViewController(viewModel: viewModel)
        presenter?.viewControllers = [viewController]
    }

    func openAddRegister() {
        //TODO: - handle it
    }
}
