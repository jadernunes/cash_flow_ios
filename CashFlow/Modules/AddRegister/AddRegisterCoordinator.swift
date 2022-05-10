//
//  AddRegisterCoordinator.swift
//  CashFlow
//
//  Created by Jader Nunes on 08/05/22.
//

import UIKit
import SwiftUI

protocol AddRegisterCoordinatorProtocol {
    func close()
    func selectRegisterType(delegate: AddRegisterViewModelProtocol)
}

final class AddRegisterCoordinator: AddRegisterCoordinatorProtocol {

    // MARK: - Attributes

    private weak var presenter: UINavigationController?
    private let listTypes = ListTypeRegister()

    // MARK: - Life cycle

    init(presenter: UINavigationController) {
        self.presenter = presenter
    }

    // MARK: - Custom methods

    func start(delegate: AddRegisterDelegate? = nil) {
        let viewModel = AddRegisterViewModel(coordinator: self)
        viewModel.delegate = delegate
        
        let viewController = AddRegisterViewController(viewModel: viewModel)
        viewController.modalPresentationStyle = .overFullScreen
        viewController.modalTransitionStyle = .crossDissolve
        presenter?.present(viewController, animated: true)
    }

    func close() {
        presenter?.visibleViewController?.dismiss(animated: true)
    }

    func selectRegisterType(delegate: AddRegisterViewModelProtocol) {
        guard let viewController = presenter?.visibleViewController else { return }
        listTypes.delegate = delegate
        listTypes.showFrom(viewController)
    }
}
