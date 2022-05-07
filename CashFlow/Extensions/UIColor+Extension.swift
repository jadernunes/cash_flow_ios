//
//  UIColor+Extension.swift
//  CashFlow
//
//  Created by Jader Nunes on 07/05/22.
//

import UIKit

extension UIColor {

    // MARK: - Custom colors

    static let clGray = gray
    static let clSecondary = white
    static let clSeparator = lightGray
    static let clNoData = lightGray.withAlphaComponent(0.3)
    static let clBlack = black

    /// HEX: #FF5229
    static let clPrimary = UIColor(named: "primary")

    /// HEX: #FFFAF5
    static let clBeige = UIColor(named: "beige")

    /// HEX: #FFEAC9
    static let clBeigeDark = UIColor(named: "beigeDark")
}
