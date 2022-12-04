//
//  CurrencySetting.swift
//  FinanceManaging
//
//  Created by 中木翔子 on 2022/11/17.
//

import SwiftUI


//struct Money {
//   enum Currency: String {
//      case USD, CAD, MXN, JPY, EUR // supported currencies here
//   }
//
//   var amount: Decimal
//   var currency: Currency
//}


struct CurrencySetting: View {
    @Environment(\.managedObjectContext) var moc
    @EnvironmentObject var chosenColor: ColorTheme // Get the object from the environment
    let baseArray = ["USD", "JPY", "EUR", "MXN"]
    @State var base = "USD"
    @State var input = "100"
    @State var currencyList = [String]()
    @State var selectedCurrencyType = [String]() // for the challenge(?)
    @State var isToggled: Bool = false // for the challenge(?)
    @FocusState private var inputIsFocused: Bool
    @State var selection = Set<String>()
    let flags = ["🇪🇺","🇯🇵","🇲🇽","🇺🇸"]
    
    func makeRequest(showAll: Bool, currencies: [String] ) {
        apiRequest(url: "https://api.exchangerate.host/latest?base=\(base)&amount=\(input)") { currency in
            var tempList = [String]()
            
            for currency in currency.rates {
                if showAll {
                    tempList.append("\(currency.key) \(String(format: "%.2f", currency.value))")
                } else if currencies.contains(currency.key) {
                    tempList.append("\(currency.key) \(String(format: "%.2f", currency.value))")
                }
                tempList.sort()
            }
            currencyList.self = tempList
            print(tempList)
        }
    }
    
    var body: some View {
        ZStack {
            chosenColor.cc
                .ignoresSafeArea()
            Color.white
            VStack {
                Text("Convert Money")
                    .foregroundColor(chosenColor.cc)
                    .font(.largeTitle)
                    .padding(.top, 40)
                
                Divider()
                    .frame(width: 230, height: 4)
                    .background(chosenColor.cc.opacity(0.7))
                    .padding(.horizontal, 10)
                    .padding(.bottom, 30)
                    .padding(.top, -10)
             
                List(currencyList, id: \.self) { type in // here we show the base and input amount
                    HStack {
                        Text(type)
                    }
                }
                VStack {
                    Rectangle()
                        .frame(height: 8.0)
                        .foregroundColor(chosenColor.cc)
                        .opacity(0.90)
                    
                    TextField("Enter an amount", text: $input)
                        .padding()
                        .background(chosenColor.cc.opacity(0.4))
                        .cornerRadius(20)
                        .padding()
                        .keyboardType(.decimalPad)
                        .focused($inputIsFocused)
                    
                    Picker("Select the currency", selection: $base) {
                        ForEach(baseArray, id: \.self) { base in
                            Text(base)
                        }
                    }
                    .pickerStyle(.segmented)
                    .padding()
                    .foregroundColor(.white)
                    .background(chosenColor.cc.opacity(0.4))
                    .cornerRadius(20)
                    .padding()
                    .focused($inputIsFocused)
                    
                    Button("Convert!") {
                        makeRequest(showAll: false, currencies: ["USD", "JPY", "EUR", "MXN"])
                        inputIsFocused = false
                    }
                    .frame(width: 100, height: 40)
                    .foregroundColor(.white)
                    .fontWeight(.semibold)
                    .background(chosenColor.cc)
                    .cornerRadius(10)
                    .padding()
                }
            }
            .onAppear {
                makeRequest(showAll: false, currencies: ["USD", "JPY", "EUR", "MXN"]) // we need to show only the selected currency type here
            }
        }
    }
    
    func flag(country:String) -> String {
        let base : UInt32 = 127397
        var s = ""
        for v in country.unicodeScalars {
            s.unicodeScalars.append(UnicodeScalar(base + v.value)!)
        }
        return String(s)
    }
} 

struct CurrencySetting_Previews: PreviewProvider {
    static var previews: some View {
        CurrencySetting()
    }
}
