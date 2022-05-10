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
        requestData()
    }

    private func requestData() {
        database.loadAll(typeSaved: RegisterCashFlowDTO.self,
                         typeToReturn: RegisterCashFlow.self) { [weak self] response  in
            switch response {
            case .success(let result):
                self?.mountSectionsBy(registers: result)
            case .failure:
                self?.configuration.send(.error)
            }
        }
    }

    private func mountSectionsBy(registers: [RegisterCashFlow]) {
        //Totals
        let dataGrouped = registersGrouped(registers)
        let viewModelTotals = TotalsComponentViewModel(data: TotalsData(income: dataGrouped.incomes,
                                                                        expense: dataGrouped.expenses))
        //Sections
        let initResult = [SectionData]()
        let sections = dataGrouped.dict.reduce(into: initResult) { list, register in
            let result = list.filter { $0.date == register.key && $0.registers.isNotEmpty }
            list.append(contentsOf: result)
            list.append(SectionData(date: register.key, registers: register.value))
        }
        let viewModelList = ListRegisterComponentViewModel(sections: sections)
        viewModelList.delegate = self

        sections.isEmpty
            ? configuration.send(.empty)
            : configuration.send(.content(viewModel: viewModelList, viewModelTotals: viewModelTotals))
    }

    private func registersGrouped(_ registers: [RegisterCashFlow]) -> (dict: Dictionary<Date, [RegisterCashFlow]>,
                                                                       expenses: Int,
                                                                       incomes: Int) {
        var totalExpenses: Int = 0
        var totalIncomes: Int = 0
        let dic =  Dictionary(grouping: registers) { register -> Date in
            switch register.type {
            case .income:
                totalIncomes += register.amount
            case .expense:
                totalExpenses += register.amount
            }
            return register.date?.toFormat(.sendShort) ?? Date()
        }

        return (dic, totalExpenses, totalIncomes)
    }

    private func deleteRegister(_ register: RegisterCashFlow?) {
        guard let register = register else { return }

        configuration.send(.loading)
        database.delete(register) { [weak self] _ in
            self?.requestData()
        }
    }
    
    func addRegister() {
        coordinator?.openAddRegister(delegate: self)
    }
}

// MARK: - ListRegister delegate

extension ListRegisterViewModel: ListRegisterDelegate {

    func willRemove(_ register: RegisterCashFlow?) {
        deleteRegister(register)
    }
}

// MARK: - AddRegister Delegate

extension ListRegisterViewModel: AddRegisterDelegate {

    func didAddRegister() {
        loadData()
    }
}
