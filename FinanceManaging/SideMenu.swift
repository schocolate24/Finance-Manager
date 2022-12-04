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
            .font(.system(size: 22))
            .fontWeight(.semibold)
            .foregroundColor(.white)
            .padding()
    }
}
extension View {
    func modification() -> some View {
        modifier(Modification())
    }
}

struct CheckboxStyle: ToggleStyle {
 
    func makeBody(configuration: Self.Configuration) -> some View {
 
        return HStack {
 
            configuration.label
 
            Spacer()
 
            Image(systemName: configuration.isOn ? "checkmark.circle.fill" : "circle")
                .resizable()
                .frame(width: 24, height: 24)
                .foregroundColor(configuration.isOn ? .white : .white)
                .font(.system(size: 20, weight: .bold, design: .default))
                .onTapGesture {
                    configuration.isOn.toggle()
                }
        }
    }
}

struct SideMenu: View {
    @EnvironmentObject var chosenColor: ColorTheme // Get the object from the environment
    @State private var tapped = false
    @AppStorage("Face ID") var showingFaceID = false

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
                    HStack {
                        Image(systemName: "gear")
                        Text("Security")
                        Image(systemName: tapped ? "chevron.down" : "chevron.right")
                            .font(.system(size: 15))
                            .fontWeight(.semibold)
                    }
                    .modification()
                    .onTapGesture {
                        withAnimation {
                            tapped.toggle()
                        }
                    }
                    
                    if tapped {
                        HStack {
                            Divider()
                                .frame(width: 2 ,height: 50)
                                .background(.white)
                                .padding(.leading, 20)
                                .padding(.trailing, 10)
                            
                            Toggle("Face ID", isOn: $showingFaceID).frame(width: 115)
                                .foregroundColor(.white)
                                .font(.headline)
                                .fontWeight(.semibold)
                                .toggleStyle(CheckboxStyle())
                        }
                    }
                
                NavigationLink {
                    ColorSetting()
                } label: {
                    HStack {
                        Image(systemName: "paintpalette")
                        Text("Color Theme")
                        Image(systemName: "chevron.right")
                            .font(.system(size: 15))
                            .fontWeight(.semibold)
                            .foregroundColor(.white)
                    }
                    .modification()
                }
                
                NavigationLink {
                    CurrencySetting()
                } label: {
                    Image(systemName: "dollarsign.arrow.circlepath")
                    Text("Convert Money")
                    Image(systemName: "chevron.right")
                        .font(.system(size: 15))
                        .fontWeight(.semibold)
                        .foregroundColor(.white)
                }
                .modification()
            }
            Spacer()
        }
        .padding(32)
        .background(chosenColor.cc)
        .edgesIgnoringSafeArea(.bottom)
    }
}

struct SideMenu_Previews: PreviewProvider {
    static var previews: some View {
        SideMenu()
    }
}
