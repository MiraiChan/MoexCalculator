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
            
            HStack {
                
                VStack {
                    Text(viewModel.topCurrency.flag)
                        .font(.system(size: 200))
                        .minimumScaleFactor(0.01)
                        .aspectRatio(1, contentMode: .fit)
                    
                    Text(viewModel.topCurrency.rawValue)
                        .font(.title2)
                }
                .frame(height: 100)
                let topBinding = Binding<Double>(
                    get: {
                        viewModel.topAmount
                    },
                    set: {
                        viewModel.setTopAmount($0)
                    }
                )
                TextField("", value: topBinding, formatter: numberFormatter)
                    .font(.largeTitle)
                    .multilineTextAlignment(.trailing)
                    .minimumScaleFactor(0.5)
                    .keyboardType(.numberPad)
            }
            
            HStack {
                
                VStack {
                    Text(viewModel.bottomCurrency.flag)
                        .font(.system(size: 200))
                        .minimumScaleFactor(0.01)
                        .aspectRatio(1, contentMode: .fit)
                    
                    Text(viewModel.bottomCurrency.rawValue)
                        .font(.title2)
                }
                .frame(height: 100)
                
                let bottomBinding = Binding<Double>(
                    get: {
                        viewModel.bottomAmount
                    },
                    set: {
                        viewModel.setBottomAmount($0)
                    }
                )

                TextField("", value: bottomBinding, formatter: numberFormatter)
                    .font(.largeTitle)
                    .multilineTextAlignment(.trailing)
                    .minimumScaleFactor(0.5)
                    .keyboardType(.numberPad)
            }
        }
    }
    
    var numberFormatter: NumberFormatter = {
        var nf = NumberFormatter()
        nf.numberStyle = .decimal
        nf.usesGroupingSeparator = false
        nf.maximumFractionDigits = 2
        return nf
    }()
}

struct CalculatorView_Previews: PreviewProvider {
    static var previews: some View {
        CalculatorView(viewModel: CalculatorViewModel())
    }
}
