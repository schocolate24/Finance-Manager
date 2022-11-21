//
//  currency.swift
//  FinanceManaging
//
//  Created by 中木翔子 on 2022/11/17.
//

import Foundation

struct Currency: Codable, Identifiable {
    var id = UUID()
    var currency: String
}
