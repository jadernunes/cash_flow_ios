//
//  ListRegisterComponent.swift
//  CashFlow
//
//  Created by Jader Nunes on 05/05/22.
//

import UIKit

final class ListRegisterComponent: UIView {

    // MARK: - Attributes

    private weak var viewModel: ListRegisterComponentProtocol?

    // MARK: - Elements

    private let tableView: UITableView = initElement {
        $0.rowHeight = UITableView.automaticDimension
        $0.estimatedRowHeight = 100
        $0.backgroundColor = .clSecondary
        $0.separatorStyle = .none
        $0.registerCell(type: RegisterCell.self)
        .registerHeader(type: RegisterSection.self)
    }

    // MARK: - Life cycle

    init() {
        super.init(frame: .zero)

        defineSubviews()
        defineSubviewsConstraints()
        setupProtocols()
    }

    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    // MARK: - Custom methods

    private func setupProtocols() {
        tableView.dataSource = self
        tableView.delegate = self
    }

    private func defineSubviews() {
        backgroundColor = .clSecondary
        addSubview(tableView)
    }

    private func reload() {
        tableView.reloadData()
    }
}

// MARK: - TableView dataSource

extension ListRegisterComponent: UITableViewDataSource {

    //Section

    func numberOfSections(in tableView: UITableView) -> Int {
        viewModel?.countSections() ?? 0
    }

    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        guard let data = viewModel?.viewModelSectionAt(index: section) else { return nil }
        let sectionView = tableView.dequeueReusableHeaderFooterView(with: RegisterSection.self)
        sectionView.configure(with: data)
        return sectionView
    }

    //Cell

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        viewModel?.countRegistersAt(indexSection: section) ?? 0
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let viewModelCell = viewModel?.viewModelCellAt(index: indexPath.row,
                                                             onIndexSection: indexPath.section)
        else { return UITableViewCell() }

        let cell = tableView.dequeueReusableCell(with: RegisterCell.self, for: indexPath)
        cell.configure(with: viewModelCell)
        return cell
    }
}

// MARK: - TableView delegate

extension ListRegisterComponent: UITableViewDelegate {

    func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        true
    }

    func tableView(_ tableView: UITableView, editingStyleForRowAt indexPath: IndexPath) -> UITableViewCell.EditingStyle {
        .delete
    }

    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        viewModel?.remove(index: indexPath.row, onIndexSection: indexPath.section)
    }
}

// MARK: - Constraints

extension ListRegisterComponent {

    private func defineSubviewsConstraints() {
        tableView.anchor(self)
    }
}

// MARK: - Component

extension ListRegisterComponent: Component {

    enum ListRegisterState {
        case reload, content(viewModel: ListRegisterComponentProtocol)
    }

    func render(with configuration: ListRegisterState) {
        switch configuration {
        case .content(let viewModel):
            self.viewModel = viewModel
            reload()
        case .reload:
            reload()
        }
    }
}
