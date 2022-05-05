//
//  ListRegisterViewController.swift
//  CashFlow
//
//  Created by Jader Nunes on 05/05/22.
//

import UIKit

final class ListRegisterViewController: UIViewController {

    // MARK: - Attributes

    private let viewModel: ListRegisterViewModelProtocol

    // MARK: - Elements

    private let content = ListRegisterContent()

    // MARK: - Life cycle

    init(viewModel: ListRegisterViewModelProtocol) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)

        content.viewModel = viewModel
    }

    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func loadView() {
        view = content
    }
}
