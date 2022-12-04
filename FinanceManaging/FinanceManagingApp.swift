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
    @StateObject var chosenColor = ColorTheme() // Initialize ColorTheme right at the start of the app
    var colorData = ColorData()
    
    var body: some Scene {
        WindowGroup {
            ContentView()
                .environment(\.managedObjectContext, dataController.container.viewContext)
                .environmentObject(chosenColor) // Place the object into the environment
                .onAppear {
                    chosenColor.cc = colorData.loadColor()
                }
                .environmentObject(chosenColor)
        }
    }
}


