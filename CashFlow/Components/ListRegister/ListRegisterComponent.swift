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
    private var isEditing = false
    private var canDelete = false

    // MARK: - Elements

    private let buttonEdit: UIButton = initElement {
        $0.addTarget(self, action: #selector(buttonEditPressed), for: .touchUpInside)
        $0.configuration = .bordered()
        $0.setTitleColor(.black, for: .normal)
    }
    
    private let tableView: UITableView = {
        $0.translatesAutoresizingMaskIntoConstraints = false
        $0.rowHeight = UITableView.automaticDimension
        $0.estimatedRowHeight = 100
        $0.backgroundColor = .clSecondary
        $0.separatorStyle = .none
        $0.registerCell(type: RegisterCell.self)
        .registerHeader(type: RegisterSection.self)
        return $0
    }(UITableView(frame: .zero, style: .grouped))

    // MARK: - Life cycle

    init() {
        super.init(frame: .zero)

        defineSubviews()
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
        tableView.isEditing = true
    }

    private func defineSubviews() {
        backgroundColor = .clSecondary
        addSubview(buttonEdit)
        addSubview(tableView)
    }

    private func reload() {
        tableView.isEditing = isEditing
        setupButtonEdit()
    }

    // MARK: - Button edit setup

    private func setupButtonEdit() {
        let titleButton = isEditing
        ? R.string.localizable.buttonTitleCancel()
        : R.string.localizable.buttonTitleEdit()

        buttonEdit.isVisible = canDelete
        buttonEdit.setTitle(titleButton, for: .normal)
    }

    private func changeEditState() {
        isEditing = !isEditing
        reload()
    }

    // MARK: - Actions

    @objc
    private func buttonEditPressed() {
        changeEditState()
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
        guard let data = viewModel?.cellDataAt(index: indexPath.row, onIndexSection: indexPath.section)
        else { return UITableViewCell() }

        let cell = tableView.dequeueReusableCell(with: RegisterCell.self, for: indexPath)
        cell.configure(with: data)
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
        defineButtonEditConstraints()
        defineTableViewConstraints()
    }

    private func defineButtonEditConstraints() {
        NSLayoutConstraint.activate([
            buttonEdit.topAnchor.constraint(equalTo: topAnchor, constant: 8),
            buttonEdit.leftAnchor.constraint(greaterThanOrEqualTo: leftAnchor, constant: 8),
            buttonEdit.rightAnchor.constraint(equalTo: rightAnchor, constant: -8),
            buttonEdit.heightAnchor.constraint(equalToConstant: canDelete ? 32 : 0)
        ])
    }

    private func defineTableViewConstraints() {
        NSLayoutConstraint.activate([
            tableView.topAnchor.constraint(equalTo: buttonEdit.bottomAnchor, constant: 4),
            tableView.leftAnchor.constraint(equalTo: leftAnchor, constant: 8),
            tableView.rightAnchor.constraint(equalTo: rightAnchor, constant: -8),
            tableView.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -8)
        ])
    }
}

// MARK: - Component

extension ListRegisterComponent: Component {

    enum ListRegisterState {
        case reload, content(viewModel: ListRegisterComponentProtocol, canDelete: Bool)
    }

    func render(with configuration: ListRegisterState) {
        isEditing = false

        switch configuration {
        case .content(let viewModel, let canDelete):
            self.viewModel = viewModel
            self.canDelete = canDelete

            reload()
        case .reload:
            reload()
        }

        defineSubviewsConstraints()
    }
}
