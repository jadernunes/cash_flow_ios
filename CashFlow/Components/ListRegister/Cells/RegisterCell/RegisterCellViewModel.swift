//
//  RegisterCellViewModel.swift
//  CashFlow
//
//  Created by Jader Nunes on 05/05/22.
//

protocol RegisterCellViewModelProtocol: AnyObject {
    var desc: String { get }
    var amount: String { get }
}

final class RegisterCellViewModel: RegisterCellViewModelProtocol {

    // MARK: - Attributes

    private let register: RegisterCashFlow
    var desc: String { register.desc }
    var amount: String {
        switch register.type {
        case .expense:
            return (-register.amount).toCurrency()
        case .income:
            return register.amount.toCurrency()
        }
    }

    // MARK: - Life cycle

    init(register: RegisterCashFlow) {
        self.register = register
    }
}
