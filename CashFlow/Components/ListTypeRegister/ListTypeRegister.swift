//
//  ListTypeRegister.swift
//  CashFlow
//
//  Created by Jader Nunes on 08/05/22.
//

import UIKit

protocol ListTypeRegisterDelegate: AnyObject {
    func didSelectType(_ type: TypeRegister)
}

final class ListTypeRegister {

    // MARK: - Attributes

    weak var delegate: ListTypeRegisterDelegate?

    // MARK: - Show list

    func showFrom( _ viewController: UIViewController) {
        let alert = UIAlertController(title: R.string.localizable.listTypeTitle(),
                                      message: nil,
                                      preferredStyle: .actionSheet)

        createActionsForTypeRegister(for: alert)
        createCancelAction(for: alert)

        viewController.present(alert, animated: true)
    }

    // MARK: - Creation of actions

    private func createActionsForTypeRegister(for alert: UIAlertController) {
        //Create a list based on all type of registers
        TypeRegister.allCases.forEach { type in
            alert.addAction(UIAlertAction(title: type.title(),
                                          style: .default,
                                          handler: { [weak self] _ in
                self?.delegate?.didSelectType(type)
            }))
        }
    }

    private func createCancelAction(for alert: UIAlertController) {
        //Action to cancel
        alert.addAction(UIAlertAction(title: R.string.localizable.cancelTitle(),
                                      style: .cancel,
                                      handler: { _ in
            alert.dismiss(animated: true)
        }))
    }
}
