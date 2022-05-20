//
//  CaloriesCalculatorApp.swift
//  CaloriesCalculator
//
//  Created by Jeems Terri Agustinus on 20/05/22.
//

import SwiftUI

@main
struct CaloriesCalculatorApp: App {
    @StateObject var userViewModel = UserViewModel()
    var body: some Scene {
        WindowGroup {
            ContentView()
                .environmentObject(userViewModel)
        }
    }
}
