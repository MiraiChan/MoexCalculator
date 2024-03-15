//
//  CalculatorView.swift
//  MoexCalculator
//
//  Created by Almira Khafizova on 13.03.24.
//

import SwiftUI

struct CalculatorView: View {
    
    @ObservedObject var viewModel: CalculatorViewModel
    @State private var isPickerPresented = false
    
    var body: some View {
        
        List {
            CurrencyInput(
                currency: viewModel.topCurrency, amount: viewModel.topAmount, calculator: viewModel.setTopAmount, tapHandler: { isPickerPresented.toggle()}
            )
            CurrencyInput(currency: viewModel.bottomCurrency, amount: viewModel.bottomAmount, calculator: viewModel.setBottomAmount, tapHandler: {isPickerPresented.toggle()}
            )
        }
        //вызов модификатора .sheet, который вызывает всплывающее окно. isPresented - отобразить или скрыть, content - содержимое всплывающего окна.
        .sheet(isPresented: $isPickerPresented) {
            VStack(spacing: 16) {
                Spacer()
                
                RoundedRectangle (cornerRadius: 3)
                    .fill(.secondary)
                    .frame(width: 60, height: 6)
                    .onTapGesture {
                        isPickerPresented = false
                    }
                
                HStack {
                    CurrencyPicker (currency: $viewModel.topCurrency, onChange: { _ in })
                    CurrencyPicker (currency: $viewModel.bottomCurrency, onChange: { _ in })
                }
            }
            
            //размер всплывающего окна
            .presentationDetents([.fraction(0.3)])
        }
    }
}

struct CalculatorView_Previews: PreviewProvider {
    static var previews: some View {
        CalculatorView(viewModel: CalculatorViewModel())
    }
}
