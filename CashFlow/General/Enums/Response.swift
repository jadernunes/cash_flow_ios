//
//  Response.swift
//  CashFlow
//
//  Created by Jader Nunes on 05/05/22.
//

enum Response<T> {
    case success(T)
    case failure(error: ErrorRequest)
}
