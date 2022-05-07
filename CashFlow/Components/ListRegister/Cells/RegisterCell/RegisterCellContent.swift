//
//  RegisterCellContent.swift
//  CashFlow
//
//  Created by Jader Nunes on 05/05/22.
//

import UIKit

final class RegisterCellContent: UIView {

    // MARK: - Attributes

    private weak var viewModel: RegisterCellViewModelProtocol?

    // MARK: - Elements

    private let descLabel: UILabel = initElement {
        $0.textColor = .black
    }

    // MARK: - Life cycle

    init() {
        super.init(frame: .zero)

        setupUI()
        defineSubviews()
        defineSubviewsConstraints()
    }

    @available(*, unavailable)
    required init?(coder: NSCoder) { fatalError("init(coder:) has not been implemented") }

    // MARK: - Custom methods

    private func defineSubviews() {
        addSubview(descLabel)
    }

    private func setupUI() {
        backgroundColor = .clBeige
        layer.cornerRadius = 8
        addShadow()
    }
}

// MARK: - Component

extension RegisterCellContent: Component {

    enum Configuration {
        case prepareForReuse, content(viewModel: RegisterCellViewModelProtocol)
    }

    func render(with configuration: Configuration) {
        switch configuration {
        case .content(let viewModel):
            self.viewModel = viewModel
            populdateUI()

        case .prepareForReuse:
            descLabel.text = nil
        }
    }

    private func populdateUI() {
        descLabel.text = viewModel?.desc
    }
}

// MARK: - Constraints

extension RegisterCellContent {

    private func defineSubviewsConstraints() {
        setupTitleConstraints()
    }

    private func setupTitleConstraints() {
        NSLayoutConstraint.activate([
            descLabel.topAnchor.constraint(equalTo: topAnchor, constant: 16),
            descLabel.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -16),
            descLabel.leftAnchor.constraint(equalTo: leftAnchor, constant: 8),
            descLabel.rightAnchor.constraint(greaterThanOrEqualTo: rightAnchor, constant: -8),
        ])
    }
}
