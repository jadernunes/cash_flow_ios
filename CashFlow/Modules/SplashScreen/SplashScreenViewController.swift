//
//  SplashScreenViewController.swift
//  CashFlow
//
//  Created by Jader Nunes on 09/05/22.
//

import UIKit

final class SplashScreenViewController: UIViewController {

    // MARK: - Attributes

    private let viewModel: SplashScreenViewModelProtocol

    // MARK: - Elements

    private let logoImageView: UIImageView = initElement {
        $0.image = UIImage.iconDollar
        $0.contentMode = .scaleAspectFit
    }

    // MARK: - Life cycle

    init(viewModel: SplashScreenViewModelProtocol) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }

    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        setupUI()
        animateLogo(counRun: 0)
    }

    // MARK: - Custom methods

    private func setupUI() {
        view.backgroundColor = .white
        createElements()
    }

    @objc private func animateLogo(counRun: Int) {
        guard counRun < 2 else {
            UIView.animate(withDuration: 0.2) { [weak self] in
                self?.logoImageView.alpha = 0.0
            } completion: { [weak self] _ in
                self?.viewModel.openMainApp()
            }
            return
        }

        UIView.animate(withDuration: 2.0) { [weak self] in
            self?.logoImageView.transform = CGAffineTransform(rotationAngle: .pi)
            self?.logoImageView.transform = CGAffineTransform(rotationAngle: .pi * 2)
        }

        DispatchQueue.main.asyncAfter(deadline: .now() + 1.0) { [weak self] in
            self?.animateLogo(counRun: counRun + 1)
        }
    }
}

// MARK: - Create elements

private extension SplashScreenViewController {

    func createElements() {
        view.addSubview(logoImageView)
        setupImageConstraints()
    }

    // MARK: - Create constraints

    private func setupImageConstraints() {
        NSLayoutConstraint.activate([
            logoImageView.centerYAnchor.constraint(equalTo: view.safeAreaLayoutGuide.centerYAnchor),
            logoImageView.centerXAnchor.constraint(equalTo: view.safeAreaLayoutGuide.centerXAnchor),
            logoImageView.widthAnchor.constraint(equalTo: view.safeAreaLayoutGuide.widthAnchor, multiplier: 0.5),
            logoImageView.heightAnchor.constraint(equalTo: view.safeAreaLayoutGuide.widthAnchor, multiplier: 0.5)
        ])
    }
}
