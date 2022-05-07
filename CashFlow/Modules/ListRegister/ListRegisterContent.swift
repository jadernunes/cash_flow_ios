//
//  ListRegisterContent.swift
//  CashFlow
//
//  Created by Jader Nunes on 05/05/22.
//

import UIKit

final class ListRegisterContent: UIView {

    // MARK: - Elements

    weak var viewModel: ListRegisterViewModelProtocol?
    private let listComponent: ListRegisterComponent = initElement()

    // MARK: - Life cycle

    init() {
        super.init(frame: .zero)

        defineSubviews()
        defineSubviewsConstraints()
    }

    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    // MARK: - Custom methods

    private func defineSubviews() {
        backgroundColor = .clSecondary
        addSubview(listComponent)
    }
}

// MARK: - Constraints

extension ListRegisterContent {

    private func defineSubviewsConstraints() {
        listComponent.anchor(self)
    }
}

// MARK: - Component

extension ListRegisterContent: Component {
    
    func render(with configuration: ListRegisterConfiguration) {
        switch configuration {
        case .idle:
            stopLoader()
            listComponent.isHidden = true

        case .loading:
            startLoader(style: .large)
            listComponent.isHidden = true

        case .content(let subViewModel):
            stopLoader()
            listComponent.isVisible = true
            listComponent.render(with: .content(viewModel: subViewModel, canDelete: true))

        case .error:
            stopLoader()
            listComponent.isHidden = true

        case .empty:
            stopLoader()
            listComponent.isHidden = true
        }
    }
}
