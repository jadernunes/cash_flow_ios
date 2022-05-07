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
        $0.textColor = .clBlack
        $0.numberOfLines = 0
        $0.font = .detail
    }
    private let amountLabel: UILabel = initElement {
        $0.textColor = .clBlack
        $0.numberOfLines = 0
        $0.font = .detail
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
        addSubview(amountLabel)
    }

    private func setupUI() {
        backgroundColor = .clBeige
        addShadow()
    }

    private func setupCorner() {
        cornerRadius(radius: 8, cornerMask: [.layerMinXMaxYCorner, .layerMaxXMaxYCorner])
    }
}

// MARK: - Component

extension RegisterCellContent: Component {

    enum Configuration {
        case prepareForReuse, content(data: CellData)
    }

    func render(with configuration: Configuration) {
        switch configuration {
        case .content(let data):
            self.viewModel = data.viewModel
            populdateUI(data.hasCorner)

        case .prepareForReuse:
            descLabel.text = nil
        }
    }

    private func populdateUI(_ hasCorner: Bool) {
        descLabel.text = viewModel?.desc
        amountLabel.text = viewModel?.amount

        if hasCorner { setupCorner() }
    }
}

// MARK: - Constraints

extension RegisterCellContent {

    private func defineSubviewsConstraints() {
        setupTitleConstraints()
        setupAmountConstraints()
    }

    private func setupAmountConstraints() {
        amountLabel.setContentCompressionResistancePriority(.required, for: .horizontal)

        NSLayoutConstraint.activate([
            amountLabel.topAnchor.constraint(equalTo: topAnchor, constant: 12),
            amountLabel.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -12),
            amountLabel.leftAnchor.constraint(greaterThanOrEqualTo: descLabel.rightAnchor, constant: 8),
            amountLabel.rightAnchor.constraint(equalTo: rightAnchor, constant: -8),
        ])
    }

    private func setupTitleConstraints() {
        NSLayoutConstraint.activate([
            descLabel.topAnchor.constraint(equalTo: topAnchor, constant: 12),
            descLabel.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -12),
            descLabel.leftAnchor.constraint(equalTo: leftAnchor, constant: 8),
        ])
    }
}
