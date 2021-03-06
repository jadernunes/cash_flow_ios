//
//  RegisterSection.swift
//  CashFlow
//
//  Created by Jader Nunes on 07/05/22.
//

import UIKit

final class RegisterSection: UITableViewHeaderFooterView {

    // MARK: - Elements

    private var viewModel: RegisterSectionViewModelProtocol?
    private let content: RegisterSectionContent = initElement()

    // MARK: - Life cycle

    override init(reuseIdentifier: String?) {
        super.init(reuseIdentifier: reuseIdentifier)
        
        defineSubviews()
        defineSubviewsConstraints()
    }
    
    @available(*, unavailable)
    required init?(coder: NSCoder) { fatalError("init(coder:) has not been implemented") }

    // MARK: - Custom methods

    override func prepareForReuse() {
        super.prepareForReuse()

        content.render(with: .prepareForReuse)
    }

    func configure(with viewModel: RegisterSectionViewModelProtocol) {
        self.viewModel = viewModel
        content.render(with: .content(viewModel: viewModel))
    }

    private func defineSubviews() {
        contentView.addSubview(content)
    }
}

// MARK: - Constraints

private extension RegisterSection {

    func defineSubviewsConstraints() {
        NSLayoutConstraint.activate([
            content.leftAnchor.constraint(equalTo: contentView.leftAnchor, constant: 4),
            content.topAnchor.constraint(equalTo: contentView.topAnchor),
            content.rightAnchor.constraint(equalTo: contentView.rightAnchor, constant: -4),
            content.bottomAnchor.constraint(equalTo: contentView.bottomAnchor)
        ])
    }
}
