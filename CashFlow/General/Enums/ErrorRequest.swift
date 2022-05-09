//
//  ErrorRequest.swift
//  CashFlow
//
//  Created by Jader Nunes on 05/05/22.
//

enum ErrorRequest: Error {
    case custom(message: String)
    case generic(message: String = "error.internal".localized())
    case genericWith(error: Error)

    var message: String {
        switch self {
        case .custom(let message):
            return message
        case .generic(let message):
            return message
        case .genericWith(_):
            //TODO: handle the error model
            return "error.internal".localized()
        }
    }
}
