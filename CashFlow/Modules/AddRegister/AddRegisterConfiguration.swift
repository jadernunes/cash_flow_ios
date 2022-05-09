//
//  AddRegisterConfiguration.swift
//  CashFlow
//
//  Created by Jader Nunes on 08/05/22.
//

enum AddRegisterConfiguration: Equatable {
    case idle, loading, error

    static func == (lhs: AddRegisterConfiguration, rhs: AddRegisterConfiguration) -> Bool {
        switch (lhs, rhs) {
        case (idle, idle),
            (loading, loading),
            (error, error):
            return true
        default:
            return false
        }
    }
}
