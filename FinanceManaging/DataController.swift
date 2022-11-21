//
//  DataController.swift
//  FinanceManaging
//
//  Created by 中木翔子 on 2022/10/08.
//

import CoreData
import Foundation

class DataController: ObservableObject {
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
