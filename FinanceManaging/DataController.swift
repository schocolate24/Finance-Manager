//
//  DataController.swift
//  FinanceManaging
//
//  Created by 中木翔子 on 2022/10/08.
//

import CoreData
import Foundation
import SwiftUI


class DataController: ObservableObject {
    @FetchRequest(entity: Finance.entity(), sortDescriptors: []) var finance: FetchedResults<Finance>
    
    var currencyUsd: [Finance] {
        finance.filter { $0.currency == "USD"}
    }
    var currencyMxn: [Finance] {
        finance.filter { $0.currency == "MXN"}
    }
    var currencyJpy: [Finance] {
        finance.filter { $0.currency == "JPY"}
    }
    var currencyEur: [Finance] {
        finance.filter { $0.currency == "EUR"}
    }
    
    let container = NSPersistentContainer(name: "Finance")
    
    init() {
        container.loadPersistentStores { description, error in
            if let error = error {
                print("Core Data failed to load: \(error.localizedDescription)")
            }
        }
    }
}

class DataControllerIncome: ObservableObject {
    let container = NSPersistentContainer(name: "Income")
    
    init() {
        container.loadPersistentStores { description, error in
            if let error = error {
                print("Core Data failed to load: \(error.localizedDescription)")
            }
        }
    }
}
