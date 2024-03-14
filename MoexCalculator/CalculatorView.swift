//
//  CalculatorView.swift
//  MoexCalculator
//
//  Created by Almira Khafizova on 13.03.24.
//

import SwiftUI

struct CalculatorView: View {
    
    @ObservedObject var viewModel: CalculatorViewModel
    
    var body: some View {
        
        List {
            CurrencyInput(currency: viewModel.topCurrency, amount: viewModel.topAmount, calculator: viewModel.setTopAmount)
            CurrencyInput(currency: viewModel.bottomCurrency, amount: viewModel.bottomAmount, calculator: viewModel.setBottomAmount)
        }
    }
}

struct CalculatorView_Previews: PreviewProvider {
    static var previews: some View {
        CalculatorView(viewModel: CalculatorViewModel())
    }
}
