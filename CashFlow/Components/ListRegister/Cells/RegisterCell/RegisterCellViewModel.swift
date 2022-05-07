//
//  RegisterCellViewModel.swift
//  CashFlow
//
//  Created by Jader Nunes on 05/05/22.
//

protocol RegisterCellViewModelProtocol: AnyObject {
    var desc: String { get }
}

final class RegisterCellViewModel: RegisterCellViewModelProtocol {

    // MARK: - Attributes

    private let register: RegisterCashFlow
    var desc: String { register.desc }

    // MARK: - Life cycle

    init(register: RegisterCashFlow) {
        self.register = register
    }
}
