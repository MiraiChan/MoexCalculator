//
//  MainView.swift
//  MoexCalculator
//
//  Created by Almira Khafizova on 15.03.24.
//

import SwiftUI

struct MainView: View {
    
    // An analog of ObservedObject. It is created in the parent object
    @EnvironmentObject var viewModel: CalculatorViewModel
    
    var body: some View {
        
        // Selecting the state and rendering the View depending on the state
        switch viewModel.state {
            
        // The loading indicator
        case .loading:
            ProgressView()
            
        // The screen that is displayed when an error occurs: emojis and text
        case .error:
            VStack {
                Text("🤷‍♂️")
                    .font(.system(size: 100))
                    .padding()
                Text("Error.\n Something is wrong.")
                    .font(.body)
            }
            .multilineTextAlignment(.center)
        
        // The calculator screen that is displayed when the data is loaded successfully
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
