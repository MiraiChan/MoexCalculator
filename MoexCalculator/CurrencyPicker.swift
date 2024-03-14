//
//  CurrencyPicker.swift
//  MoexCalculator
//
//  Created by Almira Khafizova on 14.03.24.
//

import SwiftUI

struct CurrencyPicker: View {
    
    @Binding var currency: Currency
    
    let onChange: (Currency) -> Void
    
    var body: some View {
        
        Picker("", selection: $currency) {
            
            ForEach(Currency.allCases) { currency in
                Text(currency.rawValue.uppercased())
            }
        }
        
        .pickerStyle(.wheel)
        
        
        .onChange(of: currency, perform: onChange)
    }
}

struct CurrencyPicker_Previews: PreviewProvider {
    
    static let currencyBinding = Binding<Currency>(
        get: { .RUR },
        set: { _ = $0 }
    )
    
    static var previews: some View {
        CurrencyPicker(currency: currencyBinding, onChange: { _ in })
    }
}
