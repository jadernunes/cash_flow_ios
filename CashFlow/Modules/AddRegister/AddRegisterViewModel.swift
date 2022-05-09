//
//  AddRegisterViewModel.swift
//  CashFlow
//
//  Created by Jader Nunes on 08/05/22.
//

import Foundation
import Combine

protocol AddRegisterDelegate: AnyObject {
    func didAddRegister()
}

protocol AddRegisterViewModelProtocol: ListTypeRegisterDelegate {
    var configuration: CurrentValueSubject<AddRegisterConfiguration, Never> { get }
    var typeRegister: CurrentValueSubject<TypeRegister, Never> { get }

    func close()
    func save()
    func selectRegisterType()
    func descDidChange(_ text: String)
    func amountDidChange(_ value: Int)
}

final class AddRegisterViewModel: AddRegisterViewModelProtocol {

    // MARK: - Attributes

    weak var delegate: AddRegisterDelegate?
    private let coordinator: AddRegisterCoordinatorProtocol?
    private let database: DatabaseProtocol
    private var description: String = ""
    private var amount = Int()

    var configuration = CurrentValueSubject<AddRegisterConfiguration, Never>(.idle)
    var typeRegister = CurrentValueSubject<TypeRegister, Never>(.expense)

    // MARK: - Life cycle

    init(coordinator: AddRegisterCoordinatorProtocol? = nil,
         database: DatabaseProtocol = RealmDB()) {
        self.coordinator = coordinator
        self.database = database
    }

    // MARK: - Custom methods

    func close() {
        coordinator?.close()
    }

    func save() {
        guard canSave() else {
            return //TODO: - handle error message
        }

        configuration.send(.loading)
        database.save([RegisterCashFlow(desc: description,
                                        amount: amount,
                                        date: Date().toFormat(.send) ?? Date(),
                                        type: typeRegister.value)]) { [weak self] response in
            switch response {
            case .success:
                self?.delegate?.didAddRegister()
                self?.close()
            case .failure:
                self?.configuration.send(.error)
            }
        }
    }

    private func canSave() -> Bool {
        description.count > 0 && amount > 0
    }

    func selectRegisterType() {
        coordinator?.selectRegisterType(delegate: self)
    }

    func descDidChange(_ text: String) {
        description = text
    }

    func amountDidChange(_ value: Int) {
        amount = value
    }
}

// MARK: - TypeRegister Delegate

extension AddRegisterViewModel  {

    func didSelectType(_ type: TypeRegister) {
        typeRegister.send(type)
    }
}
