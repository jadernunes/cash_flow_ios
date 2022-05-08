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
    private let errorComponent: ErrorComponent = initElement {
        $0.isHidden = true
    }
    private let emptyComponent: EmptyComponent = initElement {
        $0.isHidden = true
    }
    private let totals: TotalsComponent = initElement {
        $0.isHidden = true
    }

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
        errorComponent.delegate = self
        backgroundColor = .clSecondary
        addSubview(listComponent)
        addSubview(emptyComponent)
        addSubview(errorComponent)
        addSubview(totals)
    }
}

// MARK: - Constraints

extension ListRegisterContent {

    private func defineSubviewsConstraints() {
        emptyComponent.anchor(self)
        errorComponent.anchor(self)
        defineTotalsConstraints()
        defineListConstraints()
    }

    private func defineTotalsConstraints() {
        NSLayoutConstraint.activate([
            totals.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor),
            totals.leftAnchor.constraint(equalTo: safeAreaLayoutGuide.leftAnchor, constant: 16),
            totals.rightAnchor.constraint(equalTo: safeAreaLayoutGuide.rightAnchor, constant: -16)
        ])
    }

    private func defineListConstraints() {
        NSLayoutConstraint.activate([
            listComponent.topAnchor.constraint(equalTo: totals.bottomAnchor, constant: 4),
            listComponent.leftAnchor.constraint(equalTo: safeAreaLayoutGuide.leftAnchor, constant: 8),
            listComponent.rightAnchor.constraint(equalTo: safeAreaLayoutGuide.rightAnchor, constant: -8),
            listComponent.bottomAnchor.constraint(equalTo: safeAreaLayoutGuide.bottomAnchor, constant: -8)
        ])
    }
}

// MARK: - Error delegate

extension ListRegisterContent: ErrorComponentDelegate {

    func willRetry() {
        viewModel?.loadData()
    }
}

// MARK: - Component

extension ListRegisterContent: Component {
    
    func render(with configuration: ListRegisterConfiguration) {
        switch configuration {
        case .idle:
            stopLoader()
            listComponent.isHidden = true
            totals.isHidden = true
            emptyComponent.isHidden = true
            errorComponent.isHidden = true

        case .loading:
            startLoader(style: .large)
            listComponent.isHidden = true
            totals.isHidden = true
            emptyComponent.isHidden = true
            errorComponent.isHidden = true

        case .content(let viewModelList, let viewModelTotals):
            stopLoader()
            emptyComponent.isHidden = true
            errorComponent.isHidden = true

            //List component
            listComponent.isVisible = true
            listComponent.render(with: .content(viewModel: viewModelList, canDelete: true))

            //Totals
            totals.isVisible = true
            totals.render(with: .content(viewModel: viewModelTotals))
        case .error:
            stopLoader()
            listComponent.isHidden = true
            totals.isHidden = true
            emptyComponent.isHidden = true
            errorComponent.isVisible = true

        case .empty:
            stopLoader()
            listComponent.isHidden = true
            totals.isHidden = true
            emptyComponent.isVisible = true
            errorComponent.isHidden = true
        }
    }
}
