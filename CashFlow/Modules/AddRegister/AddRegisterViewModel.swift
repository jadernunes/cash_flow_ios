//
//  AddRegisterViewModel.swift
//  CashFlow
//
//  Created by Jader Nunes on 08/05/22.
//

import Foundation
import Combine

protocol AddRegisterDelegate: AnyObject {
    func didAddRegister() async
}

protocol AddRegisterViewModelProtocol: ListTypeRegisterDelegate {
    var configuration: CurrentValueSubject<AddRegisterConfiguration, Never> { get }
    var typeRegister: CurrentValueSubject<TypeRegisterData, Never> { get }

    func close()
    func save() async
    func selectRegisterType()
    func descDidChange(_ text: String)
    func amountDidChange(_ value: Int)
}

final class AddRegisterViewModel: AddRegisterViewModelProtocol {

    // MARK: - Attributes

    weak var delegate: AddRegisterDelegate?
    var configuration = CurrentValueSubject<AddRegisterConfiguration, Never>(.idle)
    var typeRegister = CurrentValueSubject<TypeRegisterData, Never>(.expense)
    
    private let coordinator: AddRegisterCoordinatorProtocol?
    private let service: IAddRegisterService
    private var description: String = ""
    private var amount = Int()

    // MARK: - Life cycle

    init(coordinator: AddRegisterCoordinatorProtocol? = nil,
         service: IAddRegisterService = AddRegisterService()) {
        self.coordinator = coordinator
        self.service = service
    }

    // MARK: - Custom methods

    @MainActor
    func close() {
        coordinator?.close()
    }

    func save() async {
        guard canSave() else {
            return //TODO: - handle error message
        }

        configuration.send(.loading)
        
        do {
            try await service.save(data: CashFlowData(date: Date(),
                                                      desc: description,
                                                      amount: amount,
                                                      type: typeRegister.value))
            await delegate?.didAddRegister()
            await close()
        } catch {
            configuration.send(.error)
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

    func didSelectType(_ type: TypeRegisterData) {
        typeRegister.send(type)
    }
}
