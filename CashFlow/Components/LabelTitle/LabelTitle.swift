//
//  LabelTitle.swift
//  CashFlow
//
//  Created by Jader Nunes on 07/05/22.
//

import UIKit

final class LabelTitle: UILabel {

    // MARK: - Life cycle

    init() {
        super.init(frame: .zero)
        setupUI()
    }

    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setupUI()
    }

    // MARK: - Custom methods

    private func setupUI() {
        textAlignment = .center
        font = .subTitle
    }
}
