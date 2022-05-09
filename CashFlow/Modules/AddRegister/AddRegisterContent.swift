//
//  AddRegisterContent.swift
//  CashFlow
//
//  Created by Jader Nunes on 08/05/22.
//

import UIKit
import Combine

final class AddRegisterContent: UIView {

    // MARK: - Attributes

    weak var viewModel: AddRegisterViewModelProtocol?
    private var cancelableBag = Set<AnyCancellable>()

    // MARK: - Elements

    //Dropdown

    private let labelTypeTransaction: LabelDetail = initElement()
    private let layerCloseButton: UIButton = initElement {
        $0.backgroundColor = .clear
        $0.addTarget(self, action: #selector(selectTransactionType), for: .touchUpInside)
    }
    private let stackDropDown: UIStackView = initElement {
        $0.distribution = .equalCentering
        $0.alignment = .center
        $0.backgroundColor = .white
        $0.cornerRadiusAll(radius: 4)
        $0.addShadow(opacity: 0.3)
    }
    private let imageDropdown: UIImageView = initElement {
        $0.image = UIImage.iconDown
        $0.backgroundColor = .clSeparator
        $0.contentMode = .scaleAspectFit
        $0.cornerRadiusAtSide(radius: 4, cornerMask: [.layerMaxXMinYCorner, .layerMaxXMaxYCorner])
    }

    //Other elements

    private let amountStepper: CurrencyStepper = initElement()
    private let blurView: UIView = initElement {
        $0.alpha = 0
        $0.backgroundColor = .clGray
    }
    private let contentView: UIView = initElement {
        $0.backgroundColor = .clSecondary
        $0.cornerRadiusAll(radius: 16)
        $0.addShadow(opacity: 0.5)
    }
    private let titleLabel: LabelTitle = initElement {
        $0.text = R.string.localizable.addRegisterTitle()
    }
    private let closeButton: UIButton = initElement {
        $0.setImage(UIImage.iconClose, for: .normal)
        $0.backgroundColor = .clSecondary
        $0.addTarget(self, action: #selector(buttonClosePressed), for: .touchUpInside)
    }
    private let stackCenter: UIStackView = initElement {
        $0.axis = .vertical
        $0.spacing = 24
        $0.distribution = .equalCentering
        $0.alignment = .center
    }
    private let descTextField: UITextField = initElement {
        $0.textColor = .clBlack
        $0.backgroundColor = .clSecondary
        $0.addShadow()
        $0.borderStyle = .roundedRect
        $0.placeholder = R.string.localizable.addRegisterDescPlaceholder()
    }
    private let addButton: ButtonCashFlow = initElement {
        $0.configuration = .bordered()
        $0.setTitle(R.string.localizable.addRegisterAddTitle(), for: .normal)
        $0.setTitleColor(.clBlack, for: .normal)
        $0.addTarget(self, action: #selector(buttonSavePressed), for: .touchUpInside)
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

    private func bindUI() {
        bindDesc()
        bindType()
    }

    private func setupUI() {
        backgroundColor = .clear
        amountStepper.delegate = self
        setupCloseByBlur()
        showBlur()
    }

    private func showBlur() {
        UIView.animate(withDuration: 0.1) { [weak self] in
            self?.blurView.alpha = 0.5
        }
    }

    private func setupCloseByBlur() {
        blurView.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(buttonClosePressed)))
    }

    private func defineSubviews() {
        //Base views
        addSubview(blurView)
        addSubview(contentView)

        //Adding elements on the content
        contentView.addSubview(closeButton)
        contentView.addSubview(titleLabel)
        contentView.addSubview(stackCenter)

        //Main stack that contain all center elements
        stackCenter.addArrangedSubview(stackDropDown)
        stackCenter.addArrangedSubview(descTextField)
        stackCenter.addArrangedSubview(amountStepper)
        stackCenter.addArrangedSubview(addButton)

        //Dropdown related to type of registers(transactions)
        stackDropDown.addArrangedSubview(labelTypeTransaction)
        stackDropDown.addArrangedSubview(imageDropdown)
        stackDropDown.addSubview(layerCloseButton)
    }

    // MARK: - Actions

    @objc
    private func buttonSavePressed() {
        viewModel?.save()
    }

    @objc
    private func buttonClosePressed() {
        viewModel?.close()
    }

    @objc
    private func selectTransactionType() {
        viewModel?.selectRegisterType()
    }
}

// MARK: - Binds

private extension AddRegisterContent {

    private func bindDesc() {
        descTextField.textPublisher
            .sink { [weak self] in self?.viewModel?.descDidChange($0) }
            .store(in: &cancelableBag)
    }

    private func bindType() {
        viewModel?.typeRegister
            .receive(on: DispatchQueue.main)
            .sink { [weak self] in self?.labelTypeTransaction.text = $0.title() }
            .store(in: &cancelableBag)
    }
}

// MARK: - Component

extension AddRegisterContent: Component {

    func render(with configuration: AddRegisterConfiguration) {
        switch configuration {
        case .idle:
            bindUI()
            addButton.stopLoader()

        case .loading:
            addButton.startLoader()

        case .error:
            //TODO: - handle error message
            addButton.stopLoader()
        }
    }
}

// MARK: - CurrencyStepper delegate

extension AddRegisterContent: CurrencyStepperDelegate {

    func valueDidChange(value: Int) {
        viewModel?.amountDidChange(value)
    }
}

// MARK: - Constraints

extension AddRegisterContent {

    private func defineSubviewsConstraints() {
        defineContentConstraints()
        defineTitleConstraints()
        defineCloseConstraints()
        defineDropdownConstraints()
        defineDescConstraints()
        defineAmountConstraints()
        defineAddConstraints()
    }

    private func defineContentConstraints() {
        //Defined blur
        NSLayoutConstraint.activate([
            blurView.topAnchor.constraint(equalTo: topAnchor),
            blurView.bottomAnchor.constraint(equalTo: bottomAnchor),
            blurView.leftAnchor.constraint(equalTo: leftAnchor),
            blurView.rightAnchor.constraint(equalTo: rightAnchor)
        ])

        //General content
        NSLayoutConstraint.activate([
            contentView.centerXAnchor.constraint(equalTo: centerXAnchor),
            contentView.centerYAnchor.constraint(equalTo: centerYAnchor, constant: -100),
            contentView.widthAnchor.constraint(equalTo: widthAnchor, multiplier: 0.9),
        ])

        //Stack for center
        NSLayoutConstraint.activate([
            stackCenter.leftAnchor.constraint(equalTo: contentView.leftAnchor, constant: 16),
            stackCenter.rightAnchor.constraint(equalTo: contentView.rightAnchor, constant: -16),
            stackCenter.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -16),
            stackCenter.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 16)
        ])
    }

    private func defineTitleConstraints() {
        NSLayoutConstraint.activate([
            titleLabel.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 16),
            titleLabel.leftAnchor.constraint(equalTo: contentView.leftAnchor, constant: 32),
            titleLabel.rightAnchor.constraint(equalTo: closeButton.leftAnchor),
        ])
    }

    private func defineCloseConstraints() {
        NSLayoutConstraint.activate([
            closeButton.heightAnchor.constraint(equalToConstant: 32),
            closeButton.widthAnchor.constraint(equalToConstant: 32),
            closeButton.rightAnchor.constraint(equalTo: contentView.rightAnchor, constant: -16),
            closeButton.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 16)
        ])
    }

    private func defineDropdownConstraints() {
        layerCloseButton.anchor(stackDropDown, distance: -1)
        NSLayoutConstraint.activate([
            labelTypeTransaction.widthAnchor.constraint(equalTo: descTextField.widthAnchor, constant: -32),
            labelTypeTransaction.heightAnchor.constraint(equalToConstant: 40),
            imageDropdown.heightAnchor.constraint(equalToConstant: 40),
            imageDropdown.widthAnchor.constraint(equalToConstant: 32)
        ])
    }

    private func defineDescConstraints() {
        NSLayoutConstraint.activate([
            descTextField.widthAnchor.constraint(equalTo: stackCenter.widthAnchor, multiplier: 0.8),
            descTextField.heightAnchor.constraint(equalToConstant: 40)
        ])
    }

    private func defineAddConstraints() {
        NSLayoutConstraint.activate([
            addButton.heightAnchor.constraint(equalToConstant: 32),
            addButton.widthAnchor.constraint(equalToConstant: 100)
        ])
    }

    private func defineAmountConstraints() {
        NSLayoutConstraint.activate([
            amountStepper.widthAnchor.constraint(equalTo: descTextField.widthAnchor, multiplier: 0.6),
            amountStepper.heightAnchor.constraint(equalToConstant: 40),
        ])
    }
}
