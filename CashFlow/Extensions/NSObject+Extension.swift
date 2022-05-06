//
//  NSObject+Extension.swift
//  CashFlow
//
//  Created by Jader Nunes on 05/05/22.
//

import Foundation

protocol ClassNameProtocol {
    static var className: String { get }
    var className: String { get }
}

extension ClassNameProtocol {

    static var className: String {
        String(describing: self)
    }

    var className: String {
        type(of: self).className
    }
}

extension NSObject: ClassNameProtocol {}
