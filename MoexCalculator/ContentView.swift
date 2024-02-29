//
//  ContentView.swift
//  MoexCalculator
//
//  Created by Almira Khafizova on 28.02.24.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        VStack {
            Image(systemName: "globe")
                .imageScale(.large)
                
            Text("Hello, world!")
                .padding()
        }
        .foregroundColor(.accentColor)
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
