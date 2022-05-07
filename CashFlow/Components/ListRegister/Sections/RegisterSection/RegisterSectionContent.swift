//
//  RegisterSectionContent.swift
//  CashFlow
//
//  Created by Jader Nunes on 07/05/22.
//

import UIKit

final class RegisterSectionContent: UIView {

    // MARK: - Attributes

    private weak var viewModel: RegisterSectionViewModelProtocol?

    // MARK: - Elements

    private let titleLabel: UILabel = initElement {
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
        addSubview(titleLabel)
    }

    private func setupUI() {
        backgroundColor = .clBeigeDark
        layer.cornerRadius = 8
        addShadow()
    }
}

// MARK: - Component

extension RegisterSectionContent: Component {

    enum Configuration {
        case prepareForReuse, content(viewModel: RegisterSectionViewModelProtocol)
    }

    func render(with configuration: Configuration) {
        switch configuration {
        case .content(let viewModel):
            self.viewModel = viewModel
            populdateUI()

        case .prepareForReuse:
            titleLabel.text = nil
        }
    }

    private func populdateUI() {
        titleLabel.text = viewModel?.title
    }
}

// MARK: - Constraints

extension RegisterSectionContent {

    private func defineSubviewsConstraints() {
        setupTitleConstraints()
    }

    private func setupTitleConstraints() {
        NSLayoutConstraint.activate([
            titleLabel.topAnchor.constraint(equalTo: topAnchor, constant: 16),
            titleLabel.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -16),
            titleLabel.leftAnchor.constraint(equalTo: leftAnchor, constant: 8),
            titleLabel.rightAnchor.constraint(greaterThanOrEqualTo: rightAnchor, constant: -8),
        ])
    }
}