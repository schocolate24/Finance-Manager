//
//  DecodeManager.swift
//  FinanceManaging
//
//  Created by 中木翔子 on 2022/11/17.
//

import Foundation


class Currencies: ObservableObject {
    @Published var currencies = [Currency]() {
        didSet {
            if let encoded = try? JSONEncoder().encode(currencies) {
                UserDefaults.standard.set(encoded, forKey: "money")
            }
        }
    }
    
    init() {
        if let savedItems = UserDefaults.standard.data(forKey: "money") {
            if let decodedItems = try? JSONDecoder().decode([Currency].self, from: savedItems) {
                currencies = decodedItems
                return
            }
        }
        currencies = []
    }
}
