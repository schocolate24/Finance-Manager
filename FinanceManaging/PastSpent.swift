//
//  PastSpent.swift
//  FinanceManaging
//
//  Created by 中木翔子 on 2022/10/08.
//

import SwiftUI

struct SpendingSection: View {
    @FetchRequest(entity: Finance.entity(),  sortDescriptors: []) var finances: FetchedResults<Finance>
    @EnvironmentObject var chosenColor: ColorTheme // Get the object from the environment

    enum SortType: String, CaseIterable {
        case date
        case expensive
        case cheap
    }
    @State var sort = SortType.date
    
    let title: String
    let expenses: [Finance]
    let deleteItems: (IndexSet) -> Void
    
    var body: some View {
        Section(title) {
            ForEach(sortingOptions) { finance in
                HStack {
                    VStack(alignment: .leading) {
                        Text(finance.name ?? "")
                            .foregroundColor(chosenColor.cc)
                        Text(finance.category ?? "")
                            .foregroundColor(.secondary)
                    }
                    Spacer()
                    VStack {
                        Text("\(finance.spending, format: .currency(code: finance.currency ?? "USD"))")
                            .font(.headline)
                        
                        Text((finance.date?.displayFormat)!)
                            .foregroundColor(.secondary)
                    }
                }
            }
        }
    }
    
    var sortingOptions: [Finance] {
        switch sort {
        case .date:
            return finances.sorted { $0.date! > $1.date! }
        case .expensive:
            return finances.sorted { $0.spending > $1.spending }
        case .cheap:
            return finances.sorted { $0.spending < $1.spending }
        }
    }
}


struct PastSpent: View {
    
    enum SortType: String, CaseIterable {
        case date
        case expensive
        case cheap
    }
    @State var sort = SortType.date
    
    @Environment(\.managedObjectContext) var moc
    @FetchRequest(sortDescriptors: []) var finances: FetchedResults<Finance>
    @EnvironmentObject var chosenColor: ColorTheme // Get the object from the environment
    var addspent = AddSpent()
    
    
//    var currencyUsd: [Finance] {
//        finances.filter { $0.currency == "USD"}
//    }
//    var currencyMxn: [Finance] {
//        finances.filter { $0.currency == "MXN"}
//    }
//    var currencyJpy: [Finance] {
//        finances.filter { $0.currency == "JPY"}
//    }
//    var currencyEur: [Finance] {
//        finances.filter { $0.currency == "EUR"}
//    }
    
    @StateObject var finance = DataController()
    
    var body: some View {
        NavigationView {
            VStack {
                Picker("sort by...", selection: $sort) {
                    ForEach(SortType.allCases, id: \.self) { item in
                        Text(item.rawValue)
                    }
                }
                .padding()
                .background(chosenColor.cc.opacity(0.3))
                .cornerRadius(10)
                .padding()
                .pickerStyle(.segmented)
                
                
                List {
                    SpendingSection(title: "USD", expenses: finance.currencyUsd, deleteItems: removeUsdItems)
                    SpendingSection(title: "MXN", expenses: finance.currencyUsd, deleteItems: removeMxnItems)
                    SpendingSection(title: "JPY", expenses: finance.currencyUsd, deleteItems: removeJpyItems)
                    SpendingSection(title: "EUR", expenses: finance.currencyUsd, deleteItems: removeEurItems)
                }
//                List {
//                    ForEach(sortingOptions) { finance in
//                        HStack {
//                            VStack(alignment: .leading) {
//                                Text(finance.name ?? "")
//                                    .foregroundColor(chosenColor.cc)
//                                Text(finance.category ?? "")
//                                    .foregroundColor(.secondary)
//                            }
//                            Spacer()
//                            VStack {
//                                Text("\(finance.spending, format: .currency(code: finance.currency ?? "USD"))")
//                                    .font(.headline)
//
//                                Text((finance.date?.displayFormat)!)
//                                    .foregroundColor(.secondary)
//                            }
//                        }
//                    }
//                    .onDelete(perform: deleteSpending)
//                } // the end of the List
                .navigationTitle("Past Spendings")
                .navigationBarTitleDisplayMode(.inline)
                .toolbar {
                    ToolbarItem(placement: .navigationBarLeading) {
                        EditButton()
                            .foregroundColor(chosenColor.cc)
                    }
                }
            }
        }
    }
    
//    func deleteSpending(at offsets: IndexSet) {
//        for offset in offsets {
//            let finance = finances[offset]
//            moc.delete(finance)
//        }
//        try? moc.save()
//    }
    
    func removeItems(at offsets: IndexSet, in inputArray: [Finance]) { // function used to delete items in our list
            var objectsToDelete = IndexSet()
            
        for offset in offsets {
           let item = inputArray[offset]
           
           if let index = finances.firstIndex(of: item) {
               objectsToDelete.insert(index)
           }
        }
        
//            finances.remove(atOffsets: objectsToDelete)
        }
        
        func removeUsdItems(at offsets: IndexSet) {
            removeItems(at: offsets, in: finance.currencyUsd)
        }
        
        func removeMxnItems(at offsets: IndexSet) {
            removeItems(at: offsets, in: finance.currencyMxn)
        }
        
        func removeJpyItems(at offsets: IndexSet) {
            removeItems(at: offsets, in: finance.currencyJpy)
        }
        
        func removeEurItems(at offsets: IndexSet) {
            removeItems(at: offsets, in: finance.currencyEur)
        }
    
    var sortingOptions: [Finance] {
        switch sort {
        case .date:
            return finances.sorted { $0.date! > $1.date! }
        case .expensive:
            return finances.sorted { $0.spending > $1.spending }
        case .cheap:
            return finances.sorted { $0.spending < $1.spending }
        }
    }
}
    
    extension Date {
        var displayFormat: String {
            self.formatted(
               .dateTime.month().day().weekday()
            )
        }
    }

struct PastSpent_Previews: PreviewProvider {
    static var previews: some View {
        PastSpent()
    }
}

