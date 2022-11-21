//
//  ContentViewModel.swift
//  FinanceManaging
//
//  Created by 中木翔子 on 2022/11/18.
//

import Foundation
import LocalAuthentication


extension ContentView {
    @MainActor class ViewModel: ObservableObject {
        @Published var isUnlocked = false
        var security = SecuritySetting()

        func authenticate() {
                let context = LAContext()
                var error: NSError?
                    if context.canEvaluatePolicy(.deviceOwnerAuthenticationWithBiometrics, error: &error) {
                        let reason = "We need to unlock your data"
                        
                        context.evaluatePolicy(.deviceOwnerAuthenticationWithBiometrics, localizedReason: reason) { success, authenticationError in
                            if success {
                                Task { @MainActor in
                                    self.isUnlocked = true
                                }
                            } else {
                                print("There was something wrong")
                            }
                        }
                    } else {
                        print("No biometrics")
                
            }
        }
    }
}
