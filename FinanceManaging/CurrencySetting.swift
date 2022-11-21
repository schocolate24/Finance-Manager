//
//  CurrencySetting.swift
//  FinanceManaging
//
//  Created by 中木翔子 on 2022/11/17.
//

import SwiftUI


struct CurrencySetting: View {
    
    let currencies = ["USD", "CAD", "MXN", "JPY", "EUR"]
    @AppStorage("CAD") var currency = "CAD"
    var body: some View {
        VStack {
            Form {
                Picker("Currency", selection: $currency) {
                    ForEach(currencies, id: \.self) {
                        Text($0)
                    }
                }
            }
        }
    }
}

struct CurrencySetting_Previews: PreviewProvider {
    static var previews: some View {
        CurrencySetting()
    }
}
