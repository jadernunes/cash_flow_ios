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

    func loadData() async
    func addRegister()
}

final class ListRegisterViewModel: ListRegisterViewModelProtocol {

    // MARK: - Attributes

    private let coordinator: ListRegisterCoordinatorProtocol?
    private let service: IListRegisterService

    var configuration = CurrentValueSubject<ListRegisterConfiguration, Never>(.idle)

    // MARK: - Life cycle

    init(coordinator: ListRegisterCoordinatorProtocol? = nil,
         service: IListRegisterService = ListRegisterService()) {
        self.coordinator = coordinator
        self.service = service
    }

    // MARK: - Custom methods

    func loadData() async {
        await requestData()
    }

    private func requestData() async {
        configuration.send(.loading)
        
        do {
            let data = try await service.loadAllData()
            mountSectionsBy(registers: data)
        } catch {
            configuration.send(.error)
        }
    }

    private func mountSectionsBy(registers: [ICashFlowData]) {
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

    private func registersGrouped(_ registers: [ICashFlowData]) -> (dict: Dictionary<Date, [ICashFlowData]>,
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
            return register.date.toFormat(.sendShort) ?? Date()
        }

        return (dic, totalExpenses, totalIncomes)
    }

    private func deleteRegister(_ register: ICashFlowData) async {
        configuration.send(.loading)
        
        do {
            try await service.delete(date: register.date)
            configuration.send(.idle)
            await requestData()
        } catch {
            configuration.send(.error)
        }
    }
    
    func addRegister() {
        coordinator?.openAddRegister(delegate: self)
    }
}

// MARK: - ListRegister delegate

extension ListRegisterViewModel: ListRegisterDelegate {

    func willRemove(_ register: ICashFlowData?) async {
        guard let register = register else { return }
        
        await deleteRegister(register)
    }
}

// MARK: - AddRegister Delegate

extension ListRegisterViewModel: AddRegisterDelegate {

    func didAddRegister() async {
        await loadData()
    }
}
