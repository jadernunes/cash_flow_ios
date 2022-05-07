//
//  ListRegisterViewModel.swift
//  CashFlow
//
//  Created by Jader Nunes on 05/05/22.
//

import Foundation
import Combine

protocol ListRegisterViewModelProtocol: AnyObject {
    var configuration: CurrentValueSubject<ListRegisterConfiguration, Never> { get }

    func loadData()
    func addRegister()
}

final class ListRegisterViewModel: ListRegisterViewModelProtocol {

    // MARK: - Attributes

    private let coordinator: ListRegisterCoordinatorProtocol?
    private let database: DatabaseProtocol

    var configuration = CurrentValueSubject<ListRegisterConfiguration, Never>(.idle)

    // MARK: - Life cycle

    init(coordinator: ListRegisterCoordinatorProtocol? = nil,
         database: DatabaseProtocol = RealmDB()) {
        self.coordinator = coordinator
        self.database = database
    }

    // MARK: - Custom methods

    func loadData() {
        configuration.send(.loading)
        database.loadAll(typeSaved: RegisterCashFlowDTO.self,
                         typeToReturn: RegisterCashFlow.self) { [weak self] response  in
            switch response {
            case .success(let result):
                let viewModel = ListRegisterComponentViewModel(data: result)
                viewModel.delegate = self
                self?.configuration.send(.content(viewModel: viewModel))
            case .failure:
                self?.configuration.send(.error)
            }
        }
    }
    
    func addRegister() {
        //TODO: - handle it
    }
}

// MARK: - ListRegister delegate

extension ListRegisterViewModel: ListRegisterDelegate {

    func willRemove(_ register: RegisterCashFlow?) {
        loadData()
    }
}
