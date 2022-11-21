//
//  FinanceManagingApp.swift
//  FinanceManaging
//
//  Created by 中木翔子 on 2022/10/02.
//

import SwiftUI

@main
struct FinanceManagingApp: App {
    @StateObject private var dataController = DataController()
    var body: some Scene {
        WindowGroup {
            ContentView()
                .environment(\.managedObjectContext, dataController.container.viewContext)
        }
    }
}
