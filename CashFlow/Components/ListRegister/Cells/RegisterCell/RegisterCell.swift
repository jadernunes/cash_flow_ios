//
//  RegisterCell.swift
//  CashFlow
//
//  Created by Jader Nunes on 05/05/22.
//

import UIKit

final class RegisterCell: UITableViewCell {

    // MARK: - Elements

    private var viewModel: RegisterCellViewModelProtocol?
    private let content: RegisterCellContent = initElement()

    // MARK: - Life cycle

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)

        setupUI()
        defineSubviews()
        defineSubviewsConstraints()
    }

    @available(*, unavailable)
    required init?(coder: NSCoder) { fatalError("init(coder:) has not been implemented") }

    // MARK: - Custom methods

    private func setupUI() {
        selectionStyle = .none
    }

    override func prepareForReuse() {
        super.prepareForReuse()

        content.render(with: .prepareForReuse)
    }

    func configure(with data: CellData) {
        self.viewModel = data.viewModel
        content.render(with: .content(data: data))
    }

    private func defineSubviews() {
        contentView.addSubview(content)
    }
}

// MARK: - Constraints

extension RegisterCell {

    private func defineSubviewsConstraints() {
        NSLayoutConstraint.activate([
            content.leftAnchor.constraint(equalTo: contentView.leftAnchor, constant: 4),
            content.rightAnchor.constraint(equalTo: contentView.rightAnchor, constant: -4),
            content.topAnchor.constraint(equalTo: contentView.topAnchor),
            content.bottomAnchor.constraint(equalTo: contentView.bottomAnchor)
        ])
    }
}
