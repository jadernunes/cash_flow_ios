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
    private let heightButtonAdd: CGFloat = 56
    private let listComponent: ListRegisterComponent = initElement()
    private let errorComponent: ErrorComponent = initElement {
        $0.isHidden = true
    }
    private let totals: TotalsComponent = initElement {
        $0.isHidden = true
    }
    private let buttonAdd: UIButton = initElement {
        $0.isHidden = true
        $0.setImage(UIImage.iconPlus, for: .normal)
        $0.backgroundColor = .clSecondary
        $0.layer.borderColor = UIColor.clBlack.cgColor
        $0.layer.borderWidth = 1
        $0.addTarget(self, action: #selector(buttonAddPressed), for: .touchUpInside)
    }

    // MARK: - Life cycle

    init() {
        super.init(frame: .zero)

        setupUI()
        defineSubviews()
        defineSubviewsConstraints()
    }

    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    // MARK: - Custom methods

    private func setupUI() {
        buttonAdd.cornerRadiusAll(radius: heightButtonAdd / 2)
        buttonAdd.addShadow(opacity: 0.5)
    }

    private func defineSubviews() {
        errorComponent.delegate = self
        backgroundColor = .clSecondary
        addSubview(listComponent)
        addSubview(errorComponent)
        addSubview(totals)
        addSubview(buttonAdd)
    }

    @objc
    private func buttonAddPressed() {
        viewModel?.addRegister()
    }
}

// MARK: - Constraints

extension ListRegisterContent {

    private func defineSubviewsConstraints() {
        errorComponent.anchor(self)
        defineTotalsConstraints()
        defineListConstraints()
        defineButtonAddConstraints()
    }

    private func defineButtonAddConstraints() {
        NSLayoutConstraint.activate([
            buttonAdd.heightAnchor.constraint(equalToConstant: heightButtonAdd),
            buttonAdd.widthAnchor.constraint(equalToConstant: heightButtonAdd),
            buttonAdd.rightAnchor.constraint(equalTo: safeAreaLayoutGuide.rightAnchor, constant: -32),
            buttonAdd.bottomAnchor.constraint(equalTo: safeAreaLayoutGuide.bottomAnchor, constant: -32)
        ])
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
            errorComponent.isHidden = true
            buttonAdd.isHidden = true

        case .loading:
            startLoader(style: .large)
            listComponent.isHidden = true
            totals.isHidden = true
            errorComponent.isHidden = true
            buttonAdd.isHidden = true

        case .content(let viewModelList, let viewModelTotals):
            stopLoader()
            errorComponent.isHidden = true
            buttonAdd.isVisible = true

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
            errorComponent.isVisible = true
            buttonAdd.isHidden = true

        case .empty:
            stopLoader()
            listComponent.isHidden = true
            totals.isHidden = true
            errorComponent.isHidden = true
            buttonAdd.isVisible = true
            listComponent.render(with: .empty)
        }
    }
}
