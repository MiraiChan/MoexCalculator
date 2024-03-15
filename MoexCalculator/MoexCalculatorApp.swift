//
//  MoexCalculatorApp.swift
//  MoexCalculator
//
//  Created by Almira Khafizova on 28.02.24.
//

import SwiftUI

@main
struct MoexCalculatorApp: App {
    
    @StateObject var viewModel = CalculatorViewModel()
    
    var body: some Scene {
        WindowGroup {
            MainView()
                .environmentObject(viewModel)
        }
    }
}
