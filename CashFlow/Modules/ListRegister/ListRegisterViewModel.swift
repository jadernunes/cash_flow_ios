//
//  ListRegisterViewModel.swift
//  CashFlow
//
//  Created by Jader Nunes on 05/05/22.
//

protocol ListRegisterViewModelProtocol: AnyObject {
    func addRegister()
}

final class ListRegisterViewModel: ListRegisterViewModelProtocol {

    // MARK: - Attributes

    private let coordinator: ListRegisterCoordinatorProtocol?

    // MARK: - Life cycle

    init(coordinator: ListRegisterCoordinatorProtocol? = nil) {
        self.coordinator = coordinator
    }

    // MARK: - Custom methods

    func addRegister() {
        //TODO: - handle it
    }
}
