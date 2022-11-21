//
//  AddSpent.swift
//  FinanceManaging
//
//  Created by 中木翔子 on 2022/10/08.
//

import SwiftUI

struct AddSpent: View {
    @Environment(\.managedObjectContext) var moc
    @Environment(\.dismiss) var dismiss
    @State var product = ""
    @FocusState private var amountIsFocused: Bool
    @State var date = Date.now
    @State var totalAmount = [Double]()
    @State var sum = 0.0
    @State var spending = 0.0
    
    var categories = ["Food", "Transport", "Clothes", "Entertaiment", "Bill", "Furniture", "Other"]
    @State private var category = "Food"
    var currencySetting = CurrencySetting()

    var body: some View {
        Form {
            Section {
                DatePicker(selection: $date, in: ...Date(), displayedComponents: .date) {
                    Text("Date:")
                        .foregroundColor(.cyan)
                }
            }
            Section {
                TextField("Add your product", text: $product)
            } header: {
                Text("Add product")
            }
            Section {
                Picker("Select the category: ", selection: $category) {
                    ForEach(categories, id: \.self) {
                        Text($0)
                    }
                }
                .foregroundColor(.cyan)
            }
            Section {
                TextField("Add your spending", value: $spending, format: .currency(code: currencySetting.currency))
                    .keyboardType(.decimalPad)
                    .focused($amountIsFocused)
            } header: {
                Text("Add spending")
            }
            
            Section {
                Button("Save") {
                    let newFinance = Finance(context: moc)
                    newFinance.spending = spending
                    newFinance.name = product
                    newFinance.date = date
                    
                    try? moc.save()
                    dismiss()
                    
                    spending = 0.0
                    product = ""
                    category = "Food"
                }
            }.disabled(disable())
        }
    }
    
    func disable() -> Bool {
        if spending == 0 || product == "" {
            return true
        }
        return false
    }
    
    func total() -> Double {
        totalAmount.append(spending)
        sum = totalAmount.reduce(0, +)
        let am = (sum * 100).rounded() / 100

        return am
    }
}

struct AddSpent_Previews: PreviewProvider {
    static var previews: some View {
        AddSpent()
    }
}
