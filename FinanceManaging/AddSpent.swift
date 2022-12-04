//
//  AddSpent.swift
//  FinanceManaging
//
//  Created by 中木翔子 on 2022/10/08.
//

import SwiftUI

class Currency: ObservableObject {
    let moneyType = ["USD", "MXN", "JPY", "EUR"]

}


struct AddSpent: View {
    @Environment(\.managedObjectContext) var moc
    @Environment(\.dismiss) var dismiss
    @State var product = ""
    @FocusState private var amountIsFocused: Bool
    @State var date = Date.now
    @State var totalAmount = [Double]()
    @State var sum = 0.0
    @State var spending = 0.0
    @State var category = "Food"

    @EnvironmentObject var chosenColor: ColorTheme // Get the object from the environment
    @State var currency = "MXN"
    
    let moneyType = ["USD", "MXN", "JPY", "EUR"]
//    @State var currency = "MXN" // this value is shared with other views

    var categories = ["Food", "Transport", "Fashion", "Entertaiment", "Bill", "Furnishing", "Education", "Other"]

    var body: some View {
        VStack {
            List {
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
                    .foregroundColor(chosenColor.cc)
                }
                Section {
                    Picker("Currency", selection: $currency) {
                        ForEach(moneyType, id: \.self) {
                            Text($0)
                        }
                    }
                    .pickerStyle(.segmented)
                } header: {
                    Text("Select your currency")
                }
                Section {
                    TextField("Add your spending (\(currency))", value: $spending, format: .number)
// adding spending here
                        .keyboardType(.decimalPad)
                        .focused($amountIsFocused)
                } header: {
                    Text("Add spending in: \(currency)")
                }
                Section {
                    Text("Save")
                        .onTapGesture {
                            let newFinance = Finance(context: moc)
                            newFinance.spending = spending
                            newFinance.name = product
                            newFinance.date = date
                            newFinance.category = category
                            newFinance.currency = currency
                            
                            try? moc.save()
                            dismiss()
                            spending = 0.0
                            product = ""
                            category = "Food"
                        }
                        .padding()
                        .background(chosenColor.cc)
                        .foregroundColor(.white)
                        .font(.headline)
                        .cornerRadius(10)
                        .frame(maxWidth: .infinity, alignment: .center)
                        .disabled(disable())
                }
            }
            .listStyle(GroupedListStyle())
        }
    }

    func disable() -> Bool {
        if spending == 0 || product == "" {
            return true
        }
        return false
    }
    
//    func total() -> Double {
//        totalAmount.append(spending)
//        sum = totalAmount.reduce(0, +)
//        let am = (sum * 100).rounded() / 100
//
//        return am
//    }
}

struct AddSpent_Previews: PreviewProvider {
    static var previews: some View {
        AddSpent()
    }
}

//enum Currency: String {
//    case USD
// ...
//    var code: String { return self.rawValue }
//    var symbol: String {
//        switch self {
//            case .USD: return "$"
//            // ...
//}
//}
//}
