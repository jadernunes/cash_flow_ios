//
//  CurrencyTextField.swift
//  CashFlow
//
//  Created by Jader Nunes on 09/05/22.
//

import UIKit

final class CurrencyTextField: UITextField {

    // MARK: - Attributes

    private var numbers = ""
    private var didBackspace = false

    // MARK: - Life cycle

    override init(frame: CGRect) {
        super.init(frame: frame)
        commonInit()
    }

    required init?(coder: NSCoder) {
        super.init(coder: coder)
        commonInit()
    }

    override func deleteBackward() {
        numbers = String(numbers.dropLast())
        text = Int(numbers)?.toCurrency()
        didBackspace = true
        super.deleteBackward()
    }

    //Disable functions like copy, delete
    override func canPerformAction(_ action: Selector, withSender sender: Any?) -> Bool {
        false
    }

    // MARK: - Custom methods

    private func commonInit() {
        addTarget(self, action: #selector(editingChanged), for: .editingChanged)
        font = .subDetail
    }

    @objc private func editingChanged() {
        defer {
            didBackspace = false
            text = Int(numbers)?.toCurrency()
        }

        guard
            didBackspace == false,
            let lastChar = text?.last, lastChar.isNumber else { return }

        numbers.append(lastChar)
    }
}
