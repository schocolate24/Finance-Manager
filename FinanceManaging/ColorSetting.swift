//
//  ColorSetting.swift
//  FinanceManaging
//
//  Created by 中木翔子 on 2022/11/17.
//

import SwiftUI

struct ColorData {
    private var ColorKey = "ColorKey"
    private let userDefaults = UserDefaults.standard
    
    func save(color: Color) {
        let color = UIColor(color).cgColor
        
        if let components = color.components {
            userDefaults.set(components, forKey: ColorKey)
            print("Color saved.")
        }
    }
    
    func loadColor() -> Color {
        guard let array = userDefaults.object(forKey: ColorKey) as?
                [CGFloat] else { return Color.cyan }
        
        let color = Color(.sRGB, red: array[0], green: array[1], blue: array[2], opacity: array[3])
        
        print(color)
        print("Color loaded.")
        return color
    }
}


struct ColorSetting: View {

    @State private var choosenColor: Color = Color.cyan
    private var colorData = ColorData()

    var body: some View {
        ZStack {
            choosenColor
                .edgesIgnoringSafeArea(.all)
            Color.white
            
            VStack {
                Text("Color Theme")
                    .foregroundColor(choosenColor)
                    .font(.largeTitle)
                    .padding(.top, -180)
            
                ColorPicker("Select a color", selection: $choosenColor, supportsOpacity: true)
                    .padding()
                    .cornerRadius(10)
                    .font(.system(size: 20))
                    .padding(50)
                
                Button("Save") {
                    colorData.save(color: choosenColor)
                }
                .padding()
                .background(choosenColor)
                .font(.system(size: 20))
                .cornerRadius(10)
                .foregroundColor(.white)
                .padding()
                .onAppear {
                    choosenColor = colorData.loadColor()
                }
            }
        }
    }
}
struct ColorSetting_Previews: PreviewProvider {
    static var previews: some View {
        ColorSetting()
    }
}
