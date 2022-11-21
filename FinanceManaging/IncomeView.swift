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
    var currencySetting = CurrencySetting()
    var color = ColorSetting()

    
    var body: some View {
        VStack {
            Text("Enter your income")
                .font(.title)
                .foregroundColor(.cyan)
                .padding(.bottom,30)
            
            HStack {
                TextField("Add your income:", value: $income, format: .currency(code: currencySetting.currency))
                
                Button("Save") {
                    save()
                }
                .font(.system(size: 25))
                .font(.headline)
                .foregroundColor(.white)
                .frame(width: 110, height: 45)
                .background(.cyan)
                .cornerRadius(10)
                
                .disabled(disable())
            }
            .padding([.leading,.trailing,.bottom], 30)
            
            Divider()
                .frame(width: 350, height: 2)
                .background(.gray.opacity(0.7))
                .padding(.horizontal, 10)
            
            Form {
                List {
                    ForEach(incomes) { income in
                        Text("\(income.income, format: .currency(code: currencySetting.currency))")
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
        
        try? moc.save()
        
        income = 0.0
    }
}

struct IncomeView_Previews: PreviewProvider {
    static var previews: some View {
        IncomeView()
    }
}
