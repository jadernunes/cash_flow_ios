//
//  LabelDetail.swift
//  CashFlow
//
//  Created by Jader Nunes on 07/05/22.
//

import UIKit

final class LabelDetail: UILabel {

    init() {
        super.init(frame: .zero)
        setupUI()
    }

    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setupUI()
    }

    private func setupUI() {
        textAlignment = .center
        font = .subDetail
    }
}
