//
//  ErrorRequest.swift
//  CashFlow
//
//  Created by Jader Nunes on 05/05/22.
//

enum ErrorRequest: Error {
    case custom(message: String)
    case generic(message: String = R.string.localizable.errorInternal())
    case genericWith(error: Error)

    var message: String {
        switch self {
        case .custom(let message):
            return message
        case .generic(let message):
            return message
        case .genericWith(_):
            //TODO: handle the error model
            return R.string.localizable.errorInternal()
        }
    }
}
