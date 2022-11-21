//
//  ColorTheme.swift
//  FinanceManaging
//
//  Created by 中木翔子 on 2022/11/18.
//

import Foundation
import SwiftUI


struct Colors {
    
    enum ColorTheme {
        case cyan, pink, blue, yellow, orange, green, purple
    }
    
    let color: ColorTheme
    
    var switchColors: Color {
        switch color {
        case .cyan:
            return .cyan
        case .pink:
            return .pink
        case .blue:
            return .blue
        case .yellow:
            return .yellow
        case .orange:
            return .green
        default:
            return .purple
        }
    }
}
