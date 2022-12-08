//
//  IncomeView.swift
//  FinanceManaging
//
//  Created by 中木翔子 on 2022/11/04.
//

import SwiftUI

struct IncomeView: View {
    @Environment(\.managedObjectContext) var moc
    @Environment(\.dismiss) var dismiss
    @FetchRequest(sortDescriptors: []) var incomes: FetchedResults<Income>
    @FocusState private var amountIsFocused: Bool
    @State private var income = 0.0
    @EnvironmentObject var chosenColor: ColorTheme // Get the object from the environment
    @State private var date = Date()

    var addSpent = AddSpent()
    var color = ColorSetting()

    let moneyType = ["USD", "MXN", "JPY", "EUR"]
    @State var currency = "MXN"
    
    var body: some View {
        VStack {
            Text("Enter your income")
                .font(.title)
                .foregroundColor(chosenColor.cc)
                .padding(.bottom,30)
            Divider()
                .frame(width: 230, height: 2)
                .background(chosenColor.cc.opacity(0.7))
                .padding(.top, -30)
            Section {
                Picker("Currency", selection: $currency) {
                    ForEach(moneyType, id: \.self) {
                        Text($0)
                    }
                }
                .pickerStyle(.segmented)
                .padding()
                .foregroundColor(.white)
                .background(chosenColor.cc.opacity(0.4))
                .cornerRadius(10)
                .padding()
            }
            HStack {
                TextField("in \(currency)", value: $income, format: .number)
                
                Image(systemName: "calendar")
                    .resizable()
                    .frame(width: 25, height: 25, alignment: .center)
                    .foregroundColor(chosenColor.cc)
                
                DatePicker("label", selection: $date, in: ...Date(), displayedComponents: .date)
                    .datePickerStyle(CompactDatePickerStyle())
                    .labelsHidden()
                    
                Button("Save") {
                    save()
                }
                .font(.system(size: 20))
                .font(.headline)
                .foregroundColor(.white)
                .frame(width: 80, height: 40)
                .background(chosenColor.cc)
                .cornerRadius(10)
                .disabled(disable())
            }
            .padding([.leading,.trailing], 30)
            
            Divider()
                .frame(width: 350, height: 2)
                .background(chosenColor.cc.opacity(0.7))
                .padding(.horizontal, 10)
            
            Form {
                List {
                    ForEach(sortedByDate) { income in
                        HStack {
                            Text("\(income.income, format: .currency(code: income.currency ?? "USD"))")
                            Spacer()
                            Text(income.date?.displayFormatting ?? "N/A")
                                .foregroundColor(.secondary)
                        }
                    }
                    .onDelete(perform: deleteSpending)
                }
            }
        }
    }
    func disable() -> Bool {
        if income == 0.0 {
            return true
        }
        return false
    }
    
    func deleteSpending(at offsets: IndexSet) {
        for offset in offsets {
            let income = incomes[offset]
            moc.delete(income)
        }
        try? moc.save()
    }
    
    func save() {
        let newIncome = Income(context: moc)
        newIncome.income = income
        newIncome.currency = currency
        newIncome.date = date
        
        try? moc.save()
        
        income = 0.0
    }
    
    var sortedByDate: [Income] {
        incomes.sorted { $0.date ?? Date.now > $1.date ?? Date.now}
    }
}

extension Date {
    var displayFormatting: String {
        self.formatted(
           .dateTime.month().day().weekday()
        )
    }
}


struct IncomeView_Previews: PreviewProvider {
    static var previews: some View {
        IncomeView()
    }
}


