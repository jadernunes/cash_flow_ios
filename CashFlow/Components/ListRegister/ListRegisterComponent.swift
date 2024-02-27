//
//  ListRegisterComponent.swift
//  CashFlow
//
//  Created by Jader Nunes on 05/05/22.
//

import UIKit

final class ListRegisterComponent: UIView {

    // MARK: - Attributes

    private var viewModel: ListRegisterComponentProtocol?
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
    private let emptyComponent: EmptyComponent = initElement {
        $0.isHidden = true
    }

    // MARK: - Life cycle

    init() {
        super.init(frame: .zero)

        defineSubviews()
        setupProtocols()
        defineSubviewsConstraints()
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
        addSubview(buttonEdit)
        addSubview(tableView)
        addSubview(emptyComponent)
    }

    private func reload() {
        tableView.isEditing = isEditing
        tableView.reloadData()
        setupButtonEdit()
    }

    // MARK: - Button edit setup

    private func setupButtonEdit() {
        let titleButton = isEditing
        ? "button.title.cancel".localized()
        : "button.title.edit".localized()

        buttonEdit.isVisible = canDelete
        buttonEdit.setTitle(titleButton, for: .normal)
        updateConstraintEditButton()
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
        Task { @MainActor in
            await viewModel?.remove(index: indexPath.row, onIndexSection: indexPath.section)
        }
    }
}

// MARK: - Constraints

private extension ListRegisterComponent {

    func defineSubviewsConstraints() {
        emptyComponent.anchor(self)
        defineButtonEditConstraints()
        defineTableViewConstraints()
    }

    func defineButtonEditConstraints() {
        NSLayoutConstraint.activate([
            buttonEdit.topAnchor.constraint(equalTo: topAnchor, constant: 16),
            buttonEdit.leftAnchor.constraint(greaterThanOrEqualTo: leftAnchor, constant: 8),
            buttonEdit.rightAnchor.constraint(equalTo: rightAnchor, constant: -8)
        ])
    }

    func defineTableViewConstraints() {
        NSLayoutConstraint.activate([
            tableView.leftAnchor.constraint(equalTo: leftAnchor, constant: 8),
            tableView.rightAnchor.constraint(equalTo: rightAnchor, constant: -8),
            tableView.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -8)
        ])
    }

    func updateConstraintEditButton() {
        setNeedsLayout()
        UIView.animate(withDuration: 0.2) { [weak self] in
            guard let self = self else { return }
            self.layoutIfNeeded()
            self.buttonEdit.heightAnchor.constraint(equalToConstant: self.canDelete ? 32 : 0).isActive = true
            self.tableView.topAnchor.constraint(equalTo: self.buttonEdit.bottomAnchor, constant: 16).isActive = true
        }
    }
}

// MARK: - Component

extension ListRegisterComponent: Component {

    enum ListRegisterState {
        case empty, reload, content(viewModel: ListRegisterComponentProtocol, canDelete: Bool)
    }

    func render(with configuration: ListRegisterState) {
        isEditing = false

        switch configuration {
        case .content(let viewModel, let canDelete):
            tableView.isVisible = true
            emptyComponent.isHidden = true

            self.viewModel = viewModel
            self.canDelete = canDelete
            reload()

        case .reload:
            tableView.isHidden = true
            emptyComponent.isHidden = true
            reload()

        case .empty:
            buttonEdit.isHidden = true
            tableView.isHidden = true
            emptyComponent.isVisible = true
        }
    }
}
