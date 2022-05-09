//
//  ButtonCashFlow.swift
//  CashFlow
//
//  Created by Jader Nunes on 08/05/22.
//

import UIKit

final class ButtonCashFlow: UIButton {

    // MARK: - Attributes

    private var originalButtonText: String?
    private var isLoading = false

    // MARK: - Overriding loader methods from UIView+Extension

    override func startLoader(style: UIActivityIndicatorView.Style = .medium) {
        if isLoading == false {
            originalButtonText = titleLabel?.text
            setTitle("", for: .normal)
            isUserInteractionEnabled = false
            isLoading = true

            super.startLoader(style: style)
        }
    }

    override func stopLoader() {
        if isLoading {
            isLoading = false
            setTitle(originalButtonText, for: .normal)
            isUserInteractionEnabled = true
            isLoading = false
            super.stopLoader()
        }
    }
}

