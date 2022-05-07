//
//  UITableView+Extension.swift
//  CashFlow
//
//  Created by Jader Nunes on 05/05/22.
//

import UIKit

extension UITableView {
    
    @discardableResult
    func registerCell<T: UITableViewCell>(type: T.Type) -> UITableView {
        register(type, forCellReuseIdentifier: type.className)
        return self
    }

    @discardableResult
    func registerHeader<T: UITableViewHeaderFooterView>(type: T.Type) -> UITableView {
        register(type, forHeaderFooterViewReuseIdentifier: type.className)
        return self
    }

    func dequeueReusableCell<T: UITableViewCell>(with type: T.Type, for indexPath: IndexPath) -> T {
        guard
            let reusableCell = self.dequeueReusableCell(withIdentifier: type.className, for: indexPath) as? T
        else {
            //TODO: Send error to crashlytics
            return T(frame: .zero)
        }
        return reusableCell
    }

    func dequeueReusableHeaderFooterView<T: UITableViewHeaderFooterView>(with type: T.Type) -> T {
        guard
            let header = self.dequeueReusableHeaderFooterView(withIdentifier: type.className) as? T
        else {
            //TODO: Send error to crashlytics
            return T(frame: .zero)
        }
        return header
    }
}
