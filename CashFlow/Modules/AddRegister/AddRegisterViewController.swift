//
//  AddRegisterViewController.swift
//  CashFlow
//
//  Created by Jader Nunes on 08/05/22.
//

import UIKit
import Combine

final class AddRegisterViewController: UIViewController {

    // MARK: - Attributes

    private let viewModel: AddRegisterViewModelProtocol
    private var cancelableBag = Set<AnyCancellable>()

    // MARK: - Elements

    private let content = AddRegisterContent()

    // MARK: - Life cycle

    init(viewModel: AddRegisterViewModelProtocol) {
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

    override func viewDidLoad() {
        super.viewDidLoad()
        
        bindUI()
    }

    // MARK: - Custom methods

    private func bindUI() {
        bindCongiguration()
    }
}

// MARK: - Binds

private extension AddRegisterViewController {

    func bindCongiguration() {
        viewModel.configuration
            .receive(on: DispatchQueue.main)
            .sink { [weak self] in self?.content.render(with: $0) }
            .store(in: &cancelableBag)
    }
}
