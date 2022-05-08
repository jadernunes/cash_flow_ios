//
//  TotalsComponent.swift
//  CashFlow
//
//  Created by Jader Nunes on 07/05/22.
//

import UIKit
import Combine

final class TotalsComponent: UIView {

    // MARK: - Attributes

    private weak var viewModel: TotalsComponentProtocol?
    private var cancelableBag = Set<AnyCancellable>()

    // MARK: - Elements

    private let valueExpensesLabel: LabelDetail = initElement()
    private let valueIncomeLabel: LabelDetail = initElement()
    private let valueBalanceLabel: LabelDetail = initElement()
    private let titleExpensesLabel: LabelTitle = initElement {
        $0.text = R.string.localizable.titleExpenses()
    }
    private let titleIncomeLabel: LabelTitle = initElement {
        $0.text = R.string.localizable.titleImcomes()
    }
    private let titleBalanceLabel: LabelTitle = initElement {
        $0.text = R.string.localizable.titleBalance()
    }
    private let stackLeft: UIStackView = initElement {
        $0.axis = .vertical
        $0.spacing = 16
    }
    private let stackCenter: UIStackView = initElement {
        $0.axis = .vertical
        $0.spacing = 16
        $0.addBorder(listSide: [.left, .right])
    }
    private let stackRight: UIStackView = initElement {
        $0.axis = .vertical
        $0.spacing = 16
    }
    private let stackContent: UIStackView = initElement {
        $0.distribution = .fillEqually
        $0.alignment = .center
    }
    private let progressBar: UIProgressView = initElement {
        $0.progressTintColor = .clRedLight
    }

    // MARK: - Life cycle

    init() {
        super.init(frame: .zero)

        setupUI()
        defineSubviews()
        setupStacks()
        defineSubviewsConstraints()
    }

    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    // MARK: - Custom methods

    private func setupUI() {
        backgroundColor = .clBeige
        cornerRadiusAll(radius: 8)
        progressBar.cornerRadiusAll(radius: 10)
        addShadow()
    }

    private func bindUI() {
        bindProgress()
        bindExpenses()
        bindIncomes()
        bindBalance()
    }

    private func defineSubviews() {
        addSubview(progressBar)
        addSubview(stackContent)
    }

    private func setupStacks() {
        //Left
        stackLeft.addArrangedSubview(titleExpensesLabel)
        stackLeft.addArrangedSubview(valueExpensesLabel)

        //Center
        stackCenter.addArrangedSubview(titleIncomeLabel)
        stackCenter.addArrangedSubview(valueIncomeLabel)

        //Right
        stackRight.addArrangedSubview(titleBalanceLabel)
        stackRight.addArrangedSubview(valueBalanceLabel)

        //Content
        stackContent.addArrangedSubview(stackLeft)
        stackContent.addArrangedSubview(stackCenter)
        stackContent.addArrangedSubview(stackRight)
    }
}

// MARK: - Constraints

extension TotalsComponent {

    private func defineSubviewsConstraints() {
        defineProgressConstraints()
        defineStackContentConstraints()
    }

    private func defineProgressConstraints() {
        NSLayoutConstraint.activate([
            progressBar.heightAnchor.constraint(equalToConstant: 20),
            progressBar.leftAnchor.constraint(equalTo: leftAnchor, constant: 32),
            progressBar.rightAnchor.constraint(equalTo: rightAnchor, constant: -32),
            progressBar.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -16),
            progressBar.topAnchor.constraint(equalTo: stackContent.bottomAnchor, constant: 32),
        ])
    }

    private func defineStackContentConstraints() {
        NSLayoutConstraint.activate([
            stackContent.leftAnchor.constraint(equalTo: leftAnchor, constant: 32),
            stackContent.rightAnchor.constraint(equalTo: rightAnchor, constant: -32),
            stackContent.topAnchor.constraint(equalTo: topAnchor, constant: 32),
        ])
    }
}

// MARK: - Component

extension TotalsComponent: Component {

    enum TotalsState {
        case reload, content(viewModel: TotalsComponentProtocol)
    }

    func render(with configuration: TotalsState) {
        switch configuration {
        case .content(let viewModel):
            self.viewModel = viewModel
            bindUI()
        case .reload:
            break
        }
    }
}

// MARK: - Binds

extension TotalsComponent {

    private func bindProgress() {
        viewModel?.progress
            .receive(on: DispatchQueue.main)
            .sink { [weak self] in self?.progressBar.progress = $0 }
            .store(in: &cancelableBag)
    }

    private func bindExpenses() {
        viewModel?.expenses
            .receive(on: DispatchQueue.main)
            .sink { [weak self] in self?.valueExpensesLabel.text = $0 }
            .store(in: &cancelableBag)
    }

    private func bindIncomes() {
        viewModel?.incomes
            .receive(on: DispatchQueue.main)
            .sink { [weak self] in self?.valueIncomeLabel.text = $0 }
            .store(in: &cancelableBag)
    }

    private func bindBalance() {
        viewModel?.balance
            .receive(on: DispatchQueue.main)
            .sink { [weak self] in self?.valueBalanceLabel.text = $0 }
            .store(in: &cancelableBag)
    }
}
