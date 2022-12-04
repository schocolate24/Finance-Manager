//
//  ContentView.swift
//  FinanceManaging
//
//  Created by 中木翔子 on 2022/10/02.
//


/*---------------------------------------

 # AddSpent and IncomeView have textFields to add spent and income but there's a common
   error that is when you tap the save buttons typed integers don't go back to 0 except when
   you push the enter key after you typed the amount and before you tap the save button since
   for some reason it shows the correct form of the currency format

 # you can now select your prefferd currency but the stored data doesn't change upon the changed currency type for example:
   $5 -> ¥5 Since $1 is about ¥100, this doesn't make sense
   rather then changing the whole thing, I guess it'll be a good idea not to change the currency type of existing data....
   or that might be a good idea to separate the lists of spending and income based on the currency type

 # the display of currency type needs a fix

 # done and edit button on past expences
--------------------------------------- */

import Charts
import SwiftUI


struct ContentView: View {
    @Environment(\.managedObjectContext) var moc
    @FetchRequest(sortDescriptors: []) var finance: FetchedResults<Finance>
    @State private var avarageSpentOfThePreviousMonth = 0
    @State private var showMenu: Bool = false
    @StateObject private var viewModel = ViewModel()
    @EnvironmentObject var chosenColor: ColorTheme // Get the object from the environment

    var spent = AddSpent()
    var security = SecuritySetting()
    
    var pastSpent = PastSpent()
    
    var body: some View {
//            if viewModel.isUnlocked {
                NavigationView {
                    ZStack {
                        Color(red: 0.55, green: 0.4, blue: 0.7).ignoresSafeArea()
                        Color.indigo
                        
                        TabView {
                            MainView()
                                .tabItem {
                                    Label("Home", systemImage: "house.fill")
                                }
                            AddSpent()
                                .tabItem {
                                    Label("Spent", systemImage: "arrow.up.heart")
                                }
                            PastSpent()
                                .tabItem {
                                    Label("Past Spent", systemImage: "return")
                                }
                            IncomeView()
                                .tabItem {
                                    Label("Income", systemImage: "plus.circle")
                                }
                        }
                        .toolbar {
                            Button {
                                self.showMenu.toggle()
                            } label: {
                                if showMenu {
                                    Image(systemName: "xmark")
                                        .foregroundColor(.white)
                                        .font(.title)
                                } else {
                                    Image(systemName: "text.justify")
                                        .font(.system(size: 20))
                                        .foregroundColor(chosenColor.cc)
                                        .font(.title)
                                }
                            }
                        }
                        GeometryReader { _ in
                            HStack {
                                Spacer()
                                SideMenu()
                                    .offset(x: showMenu ? 0 : UIScreen.main.bounds.width)
                                    .animation(.easeInOut(duration: 0.4), value: showMenu)
                            }
                        }
                        .background(Color.black.opacity(showMenu ? 0.5 : 0))
                    }
                } //navigationview
//            } else {
//                Button("Unlock") {
//                    viewModel.authenticate()
//                }
//                .padding()
//                .background(.blue)
//                .foregroundColor(.white)
//                .clipShape(Capsule())
//
//        }
    // the end of the if statement
    } // some: view
} // contentView

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
