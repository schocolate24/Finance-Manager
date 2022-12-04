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
        
        let color = Color(.sRGB, red: array[0], green: array[1], blue: array[2])
        
        print(color)
        print("Color loaded.")
        return color
    }
}

class ColorTheme: ObservableObject {
    @Published var cc: Color = Color.purple
}


struct CustomcolorPicker: View {
    @Binding var selectedColor: Color
    private let colors: [Color] =
    [Color("Color 1"),
     Color("Color 2"),
     Color("Color 3"),
     Color("Color 4"),
     Color("Color 5"),
     Color("Color 6"),
     Color("Color 7"),
     Color("Color 8"),
     Color("Color 9")
    ]
                                   
    var body: some View {
        
        let columns = [GridItem(.adaptive(minimum: 80))]
        HStack {
            LazyVGrid(columns: columns, spacing: 40) {
                ForEach(colors, id: \.self) { color in
                    Circle()
                        .foregroundColor(color)
                        .frame(width: 45, height: 45)
                        .onTapGesture {
                            selectedColor = color
                        }
                }
            }
        }
        .frame(maxHeight: 350)
    }
}

struct ColorSetting: View {
    @EnvironmentObject var chosenColor: ColorTheme // Get the object from the environment
    @State private var selected: Color = .red
    var colorData = ColorData()

    var body: some View {
        ZStack {
            chosenColor.cc
                .edgesIgnoringSafeArea(.all)
            Color.white
            
            VStack {
                Text("Color Theme")
                    .foregroundColor(chosenColor.cc)
                    .font(.largeTitle)
                
                Divider()
                    .frame(width: 200, height: 2)
                    .background(chosenColor.cc.opacity(0.7))
                    .padding(.horizontal, 10)
                    .padding(.top, -10)
                
                CustomcolorPicker(selectedColor: $chosenColor.cc)
                    .padding()
                    .cornerRadius(10)
                    .font(.system(size: 20))
                    .padding(50)
                    .padding(.bottom, -30
                    )
                
                Button("Save") {
                    colorData.save(color: chosenColor.cc)
                }
                .padding()
                .background(chosenColor.cc)
                .font(.system(size: 20))
                .cornerRadius(10)
                .foregroundColor(.white)
                .padding()
                .onAppear {
                    chosenColor.cc = colorData.loadColor()
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
