//
//  CalculatorViewModel.swift
//  MoexCalculator
//
//  Created by Almira Khafizova on 12.03.24.
//

import Foundation
import Combine

final class CalculatorViewModel: ObservableObject {
    
    private var model = CalculatorModel()
    
    enum State {
        case loading
        case content
        case error
    }
    
    @Published var state: State = .loading
    
    @Published var topCurrency: Currency = .CNY
    @Published var bottomCurrency: Currency = .RUR
    
    @Published var topAmount: Double = 0
    @Published var bottomAmount: Double = 0
    
    // Data loader
    private let loader: MoexDataLoader
    
    // Combine Subscriptions Storage
    private var subscriptions = Set<AnyCancellable>()
    
    // An initializer that accepts a loader variable
    init(with loader: MoexDataLoader = MoexDataLoader()) {
        self.loader = loader
        fetchData()
    }
    
    // A function that starts a data query using the loader and sets the state variable depending on the result of the download
    private func fetchData() {
        loader.fetch().sink(
            receiveCompletion: { [weak self] completion in
                guard let self = self else { return }
                if case .failure = completion {
                    self.state = .error
                }
            },
            receiveValue: { [weak self] currencyRates in
                guard let self = self else { return }
                self.model.setCurrencyRates(currencyRates)
                self.state = .content
            })
        .store(in: &subscriptions)
    }
    
    func setTopAmount(_ amount: Double) {
        topAmount = amount
        updateBottomAmount()
    }
    
    func setBottomAmount(_ amount: Double) {
        bottomAmount = amount
        updateTopAmount()
    }
    
    func updateBottomAmount() {
        let topAmount = CurrencyAmount(currency: topCurrency, amount: topAmount)
        bottomAmount = model.convert(topAmount, to: bottomCurrency)
    }
    
    func updateTopAmount() {
        let bottomAmount = CurrencyAmount(currency: bottomCurrency, amount: bottomAmount)
        topAmount = model.convert(bottomAmount, to: topCurrency)
    }
}

