//
//  WelcomeVC.swift
//  CurrencyConverter
//  Created by afon.com on 18.09.2025.
//

import SwiftUI


struct WelcomeViewController: View {
    @State private var navigate = false
    
    var body: some View {
        if navigate {
            CurrencyConverterView()
        } else {
            Text("Добро пожаловать!")
                .font(.title)
                .padding()
                .background(Color.gray)
                .cornerRadius(15)
                .shadow(radius: 5)
                .onAppear {
                    DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
                        navigate = true
                    }
                }
        }
    }
}

#Preview {
    WelcomeViewController()
}


