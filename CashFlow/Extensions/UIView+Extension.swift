//
//  UIView+Extension.swift
//  CashFlow
//
//  Created by Jader Nunes on 05/05/22.
//

import UIKit

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

    @objc
    func startLoader(style: UIActivityIndicatorView.Style = .medium) {
        let loader = UIActivityIndicatorView()
        loader.hidesWhenStopped = true
        loader.style = style
        loader.tag = tagLoader

        addSubview(loader)
        loader.startAnimating()
        loader.centerInSuperview()
    }

    @objc
    func stopLoader() {
        viewWithTag(tagLoader)?.removeFromSuperview()
    }

    func addShadow(_ offset: CGSize = .init(width: -0.05, height: 0.05), opacity: Float = 0.2)  {
        layer.shadowColor = UIColor.black.cgColor
        layer.shadowOpacity = opacity
        layer.shadowOffset = offset
        layer.shadowRadius = 2
        layer.masksToBounds = false
    }

    @discardableResult
    func cornerRadiusAll(radius: CGFloat) -> UIView {
        clipsToBounds = true
        layer.cornerRadius = radius
        return self
    }

    @discardableResult
    func cornerRadiusAtSide(radius: CGFloat, cornerMask: CACornerMask) -> UIView {
        clipsToBounds = false
        layer.cornerRadius = radius
        layer.maskedCorners = cornerMask
        return self
    }

    @discardableResult
    func addBorder(listSide: [BorderSide] = BorderSide.allCases,
                   color: UIColor = .clSeparator,
                   borderWidth: CGFloat =  1) -> UIView {
        listSide.forEach {
            switch $0 {
            case .top:
                addBorderTop(color: color, borderWidth: borderWidth)
            case .bottom:
                addBorderBottom(color: color, borderWidth: borderWidth)
            case .left:
                addBorderLeft(color: color, borderWidth: borderWidth)
            case .right:
                addBorderRight(color: color, borderWidth: borderWidth)
            }
        }
        return self
    }
}

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

// MARK: - Bords

private extension UIView {
    func addBorderTop(color: UIColor = .clSeparator, borderWidth: CGFloat = 1) {
        let border = UIView()
        border.backgroundColor = color
        border.autoresizingMask = [.flexibleWidth, .flexibleBottomMargin]
        border.frame = CGRect(x: 0, y: 0, width: frame.size.width, height: borderWidth)
        addSubview(border)
    }

    func addBorderBottom(color: UIColor = .clSeparator, borderWidth: CGFloat = 1) {
        let border = UIView()
        border.backgroundColor = color
        border.autoresizingMask = [.flexibleWidth, .flexibleTopMargin]
        border.frame = CGRect(x: 0, y: frame.size.height - borderWidth, width: frame.size.width, height: borderWidth)
        addSubview(border)
    }

    func addBorderLeft(color: UIColor = .clSeparator, borderWidth: CGFloat = 1) {
        let border = UIView()
        border.backgroundColor = color
        border.frame = CGRect(x: 0, y: 0, width: borderWidth, height: frame.size.height)
        border.autoresizingMask = [.flexibleHeight, .flexibleRightMargin]
        addSubview(border)
    }

    func addBorderRight(color: UIColor = .clSeparator, borderWidth: CGFloat = 1) {
        let border = UIView()
        border.backgroundColor = color
        border.autoresizingMask = [.flexibleHeight, .flexibleLeftMargin]
        border.frame = CGRect(x: frame.size.width - borderWidth, y: 0, width: borderWidth, height: frame.size.height)
        addSubview(border)
    }
}
