//
//  DateFormatType.swift
//  CashFlow
//
//  Created by Jader Nunes on 06/05/22.
//

import Foundation

enum DateFormatType: String, CaseIterable {
    case show = "MMMM, yyyy"
    case send = "yyyy-MM-dd hh:mm:ss"
    case sendShort = "yyyy-MM-dd"
}
