//
//  CurrencyStepper.swift
//  CashFlow
//
//  Created by Jader Nunes on 09/05/22.
//

import UIKit
import Combine

protocol CurrencyStepperDelegate: AnyObject {
    func valueDidChange(value: Int)
}

final class CurrencyStepper: UIView {

    // MARK: - Attributes

    weak var delegate: CurrencyStepperDelegate?
    private var cancelableBag = Set<AnyCancellable>()
    private var value = 0 {
        didSet {
            delegate?.valueDidChange(value: value)
            textFieldAmount.text = value.toCurrency()
        }
    }

    // MARK: - Elements

    private let stackAmount: UIStackView = initElement {
        $0.distribution = .equalCentering
        $0.alignment = .center
        $0.backgroundColor = .white
        $0.cornerRadiusAll(radius: 4)
        $0.addShadow(opacity: 0.3)
    }
    private let textFieldAmount: CurrencyTextField = initElement {
        $0.placeholder = 0.toCurrency()
    }
    private let stackButtonsAmount: UIStackView = initElement {
        $0.axis = .vertical
        $0.distribution = .equalCentering
        $0.alignment = .center
        $0.backgroundColor = .white
        $0.cornerRadiusAtSide(radius: 4, cornerMask: [.layerMaxXMinYCorner, .layerMaxXMaxYCorner])
    }
    private let buttonUp: UIButton = initElement {
        $0.backgroundColor = .clSeparator
        $0.setImage(.iconUp, for: .normal)
        $0.cornerRadiusAtSide(radius: 4, cornerMask: [.layerMaxXMinYCorner])
        $0.addTarget(self, action: #selector(buttonUpPressed), for: .touchUpInside)
    }
    private let buttonDown: UIButton = initElement {
        $0.backgroundColor = .clSeparator
        $0.setImage(.iconDown, for: .normal)
        $0.cornerRadiusAtSide(radius: 4, cornerMask: [.layerMaxXMaxYCorner])
        $0.addTarget(self, action: #selector(buttonDownPressed), for: .touchUpInside)
    }

    // MARK: - Life cycle

    init() {
        super.init(frame: .zero)

        bindUI()
        defineSubviews()
        defineSubviewsConstraints()
    }

    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    // MARK: - Custom methods

    private func bindUI() {
        bindAmount()
    }

    private func defineSubviews() {
        addSubview(stackAmount)
        stackAmount.addArrangedSubview(textFieldAmount)
        stackAmount.addArrangedSubview(stackButtonsAmount)
        stackButtonsAmount.addArrangedSubview(buttonUp)
        stackButtonsAmount.addArrangedSubview(buttonDown)
    }

    @objc
    private func buttonUpPressed() {
        value += 1
    }

    @objc
    private func buttonDownPressed() {
        value -= value > 0 ? 1 : 0
    }
}

// MARK: - Binds

private extension CurrencyStepper {
    
    func bindAmount() {
        textFieldAmount.textPublisher
            .sink { [weak self] in self?.value = Int($0.onlyDigits()) ?? 0 }
            .store(in: &cancelableBag)
    }
}

// MARK: - Constraints

private extension CurrencyStepper {

    func defineSubviewsConstraints() {
        defineAmountConstraints()

        NSLayoutConstraint.activate([
            stackAmount.heightAnchor.constraint(equalTo: heightAnchor),
            stackAmount.widthAnchor.constraint(equalTo: widthAnchor)
        ])

        NSLayoutConstraint.activate([
            buttonDown.heightAnchor.constraint(equalToConstant: 20),
            buttonDown.widthAnchor.constraint(equalToConstant: 32),
            buttonUp.widthAnchor.constraint(equalToConstant: 32),
            buttonUp.heightAnchor.constraint(equalToConstant: 20),
        ])
    }

    func defineAmountConstraints() {
        NSLayoutConstraint.activate([
            stackButtonsAmount.widthAnchor.constraint(equalToConstant: 32),
            textFieldAmount.widthAnchor.constraint(equalTo: widthAnchor, constant: -32),            textFieldAmount.heightAnchor.constraint(equalTo: heightAnchor),
        ])
    }
}
