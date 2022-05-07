//
//  UIView+Extension.swift
//  CashFlow
//
//  Created by Jader Nunes on 05/05/22.
//

import UIKit

// MARK: - Constraints

extension UIView {

    func centerInSuperview() {
        translatesAutoresizingMaskIntoConstraints = false
        guard let superview = superview else { return }

        NSLayoutConstraint.activate([
            centerYAnchor.constraint(equalTo: superview.centerYAnchor),
            centerXAnchor.constraint(equalTo: superview.centerXAnchor)
        ])
    }

    func anchor(_ view: UIView, distance: CGFloat = 8) {
        NSLayoutConstraint.activate([
            leftAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leftAnchor, constant: distance),
            rightAnchor.constraint(equalTo: view.safeAreaLayoutGuide.rightAnchor, constant: -distance),
            topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: distance),
            bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -distance),
        ])
    }
}

// MARK: - General

extension UIView {

    /// Used to work arout the activity indicator to show when the view is loading
    var tagLoader: Int { 9999 }

    var isVisible: Bool {
        set {
            self.isHidden = !newValue
        }
        get {
            return !self.isHidden
        }
    }

    func startLoader(style: UIActivityIndicatorView.Style = .medium) {
        let loader = UIActivityIndicatorView()
        loader.hidesWhenStopped = true
        loader.style = style
        loader.tag = tagLoader

        addSubview(loader)
        loader.startAnimating()
        loader.centerInSuperview()
    }

    func stopLoader() {
        viewWithTag(tagLoader)?.removeFromSuperview()
    }

    func addShadow(_ offset: CGSize = .init(width: -0.05, height: 0.05))  {
        layer.shadowColor = UIColor.black.cgColor
        layer.shadowOpacity = 0.2
        layer.shadowOffset = offset
        layer.shadowRadius = 2
        layer.masksToBounds = false
    }
}

