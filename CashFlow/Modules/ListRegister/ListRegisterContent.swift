//
//  ListRegisterContent.swift
//  CashFlow
//
//  Created by Jader Nunes on 05/05/22.
//

import UIKit

final class ListRegisterContent: UIView {

    // MARK: - Elements

    weak var viewModel: ListRegisterViewModelProtocol?

    // MARK: - Life cycle

    init() {
        super.init(frame: .zero)

        //TODO: - handle it
    }

    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
