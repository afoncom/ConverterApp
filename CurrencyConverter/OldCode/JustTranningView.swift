//
//  JustTranningView.swift
//  CurrencyConverter
//
//  Created by afon.com on 14.09.2025.
//

import SwiftUI

struct JustTranningView: View {
    var body: some View {
        VStack (alignment: .leading, spacing: 16) {
            VStack(alignment: .leading, spacing: 16) {
                Text("Лекция SwiftUI")
                    .font(.title2)
                    .bold()
                Text("В лекции познакомимся со SwiftUI и разработкой интерфейсоВ с его помощью")
            }
            HStack (spacing: 12){
                Button("Записаться") {}
                    .font(.system(size: 14))
                    .foregroundStyle(.white)
                    .padding()
                    .background(Color.blue)
                    .cornerRadius(15)
                Button {
                } label: {
                    Image(systemName: "heart")
                        .foregroundStyle(.red)
                        .padding()
                        .background(Color.white)
                        .clipShape(Circle())
                        .shadow(color: .gray, radius: 5)
                        .font(.system(size: 14))
                }
            }
            .frame(maxWidth: .infinity, alignment: .leading)
        }
        .padding()
    }
}

#Preview {
    JustTranningView()
}
