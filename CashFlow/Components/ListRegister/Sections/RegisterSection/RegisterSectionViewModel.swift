//
//  RegisterSectionViewModel.swift
//  CashFlow
//
//  Created by Jader Nunes on 07/05/22.
//

import Foundation

protocol RegisterSectionViewModelProtocol: AnyObject {
    var title: String { get }
}

final class RegisterSectionViewModel: RegisterSectionViewModelProtocol {

    // MARK: - Attributes

    private let date: Date
    var title: String { date.toString(.show) }

    // MARK: - Life cycle

    init(date: Date) {
        self.date = date
    }
}
