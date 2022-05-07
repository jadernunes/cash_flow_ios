//
//  ListRegisterConfiguration.swift
//  CashFlow
//
//  Created by Jader Nunes on 06/05/22.
//

enum ListRegisterConfiguration: Equatable {
    case idle, loading, empty, error, content(viewModel: ListRegisterComponentProtocol)

    static func == (lhs: ListRegisterConfiguration, rhs: ListRegisterConfiguration) -> Bool {
        switch (lhs, rhs) {
        case (idle, idle),
            (loading, loading),
            (empty, empty),
            (error, error),
            (content(_), content(_)):
            return true
        default:
            return false
        }
    }
}
