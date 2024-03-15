//
//  MainView.swift
//  MoexCalculator
//
//  Created by Almira Khafizova on 15.03.24.
//

import SwiftUI

struct MainView: View {
    
    // Аналог ObservedObject. Создаётся в родительском объекте
    @EnvironmentObject var viewModel: CalculatorViewModel
    
    var body: some View {
        
        // Выбор состояния и отрисовка View в зависмости от состояния
        switch viewModel.state {
            
        // Индикатор загрузки
        case .loading:
            ProgressView()
            
        // Экран, который отображается при ошибке: эмоджи и текст
        case .error:
            VStack {
                Text("🤷‍♂️")
                    .font(.system(size: 100))
                    .padding()
                Text("Что-то пошло не так.\n Пожалуйста, попробуйте позже.")
                    .font(.body)
            }
            .multilineTextAlignment(.center)
        
        // Экран калькулятора, который отображается при успешной загрузке данных
        case .content:
            CalculatorView()
            
        }
    }
}

struct MainView_Previews: PreviewProvider {
    static var previews: some View {
        MainView()
    }
}
