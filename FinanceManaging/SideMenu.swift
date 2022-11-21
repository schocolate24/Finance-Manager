//
//  SideMenu.swift
//  FinanceManaging
//
//  Created by 中木翔子 on 2022/10/09.
//

import SwiftUI

struct Modification: ViewModifier {
    func body(content: Content) -> some View {
        content
            .font(.system(size: 25))
            .foregroundColor(.white)
            .padding()
    }
}
extension View {
    func modification() -> some View {
        modifier(Modification())
    }
}

struct SideMenu: View {
  
    var body: some View {
        VStack {
            Text("Settings")
                .font(.largeTitle)
                .foregroundColor(.white)
            
            Divider()
                .frame(width: 190, height: 2)
                .background(.white)
                .padding(.horizontal, 10)
           
            VStack(alignment: .leading) {
                NavigationLink {
                    SecuritySetting()
                } label: {
                    Text("Security")
                        .modification()
                }
                
                NavigationLink {
                    ColorSetting()
                } label: {
                    Text("Color Theme")
                        .modification()
                }
                
                NavigationLink {
                    CurrencySetting()
                } label: {
                    Text("Currency Type")
                        .modification()
                }
            }
            .padding()
            
            Spacer()
        }
        .padding(32)
        .background(.cyan)
        .edgesIgnoringSafeArea(.bottom)
    }
}

struct SideMenu_Previews: PreviewProvider {
    static var previews: some View {
        SideMenu()
    }
}
