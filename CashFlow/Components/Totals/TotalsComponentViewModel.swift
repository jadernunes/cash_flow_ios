//
//  TotalsComponentViewModel.swift
//  CashFlow
//
//  Created by Jader Nunes on 07/05/22.
//

import Foundation
import Combine

protocol TotalsComponentProtocol: AnyObject {
    var incomes: CurrentValueSubject<String, Never> { get }
    var expenses: CurrentValueSubject<String, Never> { get }
    var balance: CurrentValueSubject<String, Never> { get }
    var progress: CurrentValueSubject<Float, Never> { get }
}

final class TotalsComponentViewModel: TotalsComponentProtocol {

    // MARK: - Attributes

    let incomes = CurrentValueSubject<String, Never>("")
    let expenses = CurrentValueSubject<String, Never>("")
    let balance = CurrentValueSubject<String, Never>("")
    let progress = CurrentValueSubject<Float, Never>(0)

    // MARK: - Life cycle

    init(data: TotalsData) {
        populateUI(data)
    }

    // MARK: - Custom methods

    private func populateUI(_ data: TotalsData) {
        let rest = data.income - data.expense
        expenses.send(data.expense.toCurrency())
        incomes.send(data.income.toCurrency())
        balance.send(rest.toCurrency())

        let percent = Float(data.expense) / Float(data.income)
        progress.send(percent)
    }
}
