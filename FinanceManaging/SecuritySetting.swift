//
//  SecuritySetting.swift
//  FinanceManaging
//
//  Created by 中木翔子 on 2022/11/17.
//

import LocalAuthentication
import SwiftUI

struct SecuritySetting: View {
    @AppStorage("Face ID") var showingFaceID = false
    
    var body: some View {
        VStack {
            Toggle("Face ID", isOn: $showingFaceID)
        }
        .padding()
    }
}

struct SecuritySetting_Previews: PreviewProvider {
    static var previews: some View {
        SecuritySetting()
    }
}
