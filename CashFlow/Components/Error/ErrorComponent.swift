//
//  ErrorComponent.swift
//  CashFlow
//
//  Created by Jader Nunes on 08/05/22.
//

import UIKit

protocol ErrorComponentDelegate: AnyObject {
    func willRetry()
}

final class ErrorComponent: UIView {

    // MARK: - Attributes

    weak var delegate: ErrorComponentDelegate?

    // MARK: - Elements

    private let errorImage: UIImageView = initElement {
        $0.image = UIImage.iconError
        $0.contentMode = .scaleAspectFit
    }
    private let infoLabel: LabelTitle = initElement {
        $0.text = "error.title".localized()
        $0.textAlignment = .center
    }
    private let retryButton: UIButton = initElement {
        $0.setTitle("error.retry".localized(), for: .normal)
        $0.setTitleColor(.clBlack, for: .normal)
        $0.backgroundColor = .clBeigeDark
        $0.layer.cornerRadius = 8
        $0.addTarget(self, action: #selector(retryButtonPressed), for: .touchUpInside)
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
        backgroundColor = .clSecondary
        addSubview(errorImage)
        addSubview(infoLabel)
        addSubview(retryButton)
    }

    // MARK: - Actions

    @objc private func retryButtonPressed() {
        delegate?.willRetry()
    }
}

// MARK: - Constraints

extension ErrorComponent {

    private func defineSubviewsConstraints() {
        setupLableConstraints()
        setupImageConstraints()
        setupButtonConstraints()
    }

    private func setupLableConstraints() {
        NSLayoutConstraint.activate([
            infoLabel.leftAnchor.constraint(equalTo: leftAnchor, constant: 16),
            infoLabel.rightAnchor.constraint(equalTo: rightAnchor, constant: -16),
            infoLabel.centerYAnchor.constraint(equalTo: centerYAnchor)
        ])
    }

    private func setupImageConstraints() {
        NSLayoutConstraint.activate([
            errorImage.topAnchor.constraint(greaterThanOrEqualTo: topAnchor, constant: 16),
            errorImage.leftAnchor.constraint(equalTo: leftAnchor, constant: 16),
            errorImage.rightAnchor.constraint(equalTo: rightAnchor, constant: -16),
            errorImage.heightAnchor.constraint(equalTo: widthAnchor, multiplier: 0.3),
            errorImage.centerXAnchor.constraint(equalTo: centerXAnchor),
            errorImage.bottomAnchor.constraint(equalTo: infoLabel.topAnchor, constant: -4)
        ])
    }

    private func setupButtonConstraints() {
        NSLayoutConstraint.activate([
            retryButton.heightAnchor.constraint(equalToConstant: 44),
            retryButton.widthAnchor.constraint(equalTo: errorImage.widthAnchor, multiplier: 0.5),
            retryButton.topAnchor.constraint(equalTo: infoLabel.bottomAnchor, constant: 24),
            retryButton.centerXAnchor.constraint(equalTo: centerXAnchor),
        ])
    }
}
