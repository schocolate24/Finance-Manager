//
//  MainView.swift
//  FinanceManaging
//
//  Created by 中木翔子 on 2022/11/04.
//

import SwiftUI
import Charts


enum Weekdays: String {
    case monday = "Mon"
    case tuesday = "Tue"
    case wednesday = "Wed"
    case thursday = "Thu"
    case friday = "Fri"
    case saturday = "Sat"
    case sunday = "Sun"
}

struct Spending: Identifiable {
    var id = UUID()
    var date: Weekdays
    var amount: Double
}

struct MainView: View {
    
    var data: [Spending] = [
        .init(date: .monday, amount: 1 ),
        .init(date: .tuesday, amount: 2),
        .init(date: .wednesday, amount: 3),
        .init(date: .thursday, amount: 4),
        .init(date: .friday, amount: 5),
        .init(date: .saturday, amount: 6),
        .init(date: .sunday, amount: 7)
    ]
    
    @EnvironmentObject var chosenColor: ColorTheme // Get the object from the environment
    @State private var showColorSetting = false // Add this to access ColorSetting

    var body: some View {
        ZStack {
            chosenColor.cc.opacity(0.5)
            Chart(data) { data in
                BarMark(
                    x: .value("Date", data.date.rawValue),
                    y: .value("Total spending", data.amount)
                )
                .foregroundStyle(by: .value("Date", data.date.rawValue))
            }
            .padding()
            .frame(width: 370, height: 350)
        }
    }
}


struct MainView_Previews: PreviewProvider {
    static var previews: some View {
        MainView()
    }
}
