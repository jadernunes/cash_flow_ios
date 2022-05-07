//
//  ListRegisterViewController.swift
//  CashFlow
//
//  Created by Jader Nunes on 05/05/22.
//

import UIKit
import Combine

final class ListRegisterViewController: UIViewController {

    // MARK: - Attributes

    private let viewModel: ListRegisterViewModelProtocol
    private var cancelableBag = Set<AnyCancellable>()

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

    override func viewDidLoad() {
        super.viewDidLoad()

        setupUI()
        bindUI()
        viewModel.loadData()
    }

    // MARK: - Custom methods

    private func setupUI() {
        view.backgroundColor = .clSecondary
        view.backgroundColor = .white
    }

    private func bindUI() {
        bindCongiguration()
    }
}

// MARK: - Binds

private extension ListRegisterViewController {

    func bindCongiguration() {
        viewModel.configuration
            .receive(on: DispatchQueue.main)
            .sink { [weak self] in self?.content.render(with: $0) }
            .store(in: &cancelableBag)
    }
}
