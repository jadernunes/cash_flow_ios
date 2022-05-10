//
//  ListRegisterViewModel.swift
//  CashFlow
//
//  Created by Jader Nunes on 05/05/22.
//

import Foundation

protocol ListRegisterDelegate: AnyObject {
    func willRemove(_ register: RegisterCashFlow?)
}

extension ListRegisterDelegate {
    func willRemove(_ register: RegisterCashFlow?) { }
}

protocol ListRegisterComponentProtocol: AnyObject {
    func remove(index: Int, onIndexSection: Int)

    //Section
    func countSections() -> Int
    func viewModelSectionAt(index: Int) -> RegisterSectionViewModelProtocol?

    //Cell
    func countRegistersAt(indexSection: Int) -> Int
    func cellDataAt(index: Int, onIndexSection: Int) -> CellData?
}

final class ListRegisterComponentViewModel {

    // MARK: - Attributes

    weak var delegate: ListRegisterDelegate?
    private var sections = [SectionData]()

    // MARK: - Life cycle

    init(sections: [SectionData]) {
        self.sections = sections
        sort()
    }

    // MARK: - Custom methods

    private func sort() {
        //TODO: Create an action that user can choose which sort they prefere
        sections.sort(by: { $0.date > $1.date })
    }

    private func sectionAt(index: Int) -> SectionData? {
        sections[safe: index]
    }

    private func registerAt(index: Int, sectionIndex: Int) -> RegisterCashFlow? {
        sections[safe: sectionIndex]?.registers[safe: index]
    }

    private func shouldShowCornerAt(index: Int, onSection: Int) -> Bool {
        let countRegister = countRegistersAt(indexSection: onSection)
        return index == countRegister - 1
    }
}

// MARK: - Component protocol

extension ListRegisterComponentViewModel: ListRegisterComponentProtocol {

    func remove(index: Int, onIndexSection: Int) {
        delegate?.willRemove(registerAt(index: index, sectionIndex: onIndexSection))
    }

    // MARK: - Section

    func countSections() -> Int {
        sections.count
    }

    func viewModelSectionAt(index: Int) -> RegisterSectionViewModelProtocol? {
        guard let date = sectionAt(index: index)?.date else { return nil }
        return RegisterSectionViewModel(date: date)
    }

    // MARK: - Cell

    func countRegistersAt(indexSection: Int) -> Int {
        sectionAt(index: indexSection)?.registers.count ?? 0
    }

    func cellDataAt(index: Int, onIndexSection: Int) -> CellData? {
        guard
            let register = registerAt(index: index, sectionIndex: onIndexSection)
        else { return nil }

        return CellData(viewModel: RegisterCellViewModel(register: register),
                        hasCorner: shouldShowCornerAt(index: index, onSection: onIndexSection))
    }
}
