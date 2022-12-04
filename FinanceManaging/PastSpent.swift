//
//  PastSpent.swift
//  FinanceManaging
//
//  Created by 中木翔子 on 2022/10/08.
//

import SwiftUI
import CoreData


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
                    .onDelete(perform: deleteSpending)
                } // the end of the List
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
    
    func deleteSpending(at offsets: IndexSet) {
        for offset in offsets {
            let finance = finances[offset]
            moc.delete(finance)
        }
        try? moc.save()
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

