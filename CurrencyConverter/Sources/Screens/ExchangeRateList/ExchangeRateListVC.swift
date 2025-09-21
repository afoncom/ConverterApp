//
//  ExchangeRateListVC.swift
//  CurrencyConverter
//  Created by afon.com on 13.09.2025.
//

import SwiftUI


struct ExchangeRateListView: View {
    @StateObject private var viewModel = ExchangeRateListViewModel()
    @Environment(\.presentationMode) private var presentationMode
    let onCurrencySelected: ((Currency) -> Void)?
    
    init(onCurrencySelected: ((Currency) -> Void)? = nil) {
        self.onCurrencySelected = onCurrencySelected
    }
    
    var body: some View {
        NavigationView {
            List(viewModel.items, id: \.currency.code) { item in
                Button {
                    onCurrencySelected?(item.currency)
                    presentationMode.wrappedValue.dismiss()
                } label: {
                    HStack {
                        VStack(alignment: .leading) {
                            Text(item.displayText)
                                .font(.headline)
                            Text(item.rateDisplayText)
                                .font(.subheadline)
                                .foregroundColor(.secondary)
                        }
                        Spacer()
                        Text(item.currencySymbol)
                            .font(.title2)
                    }
                    .padding(.vertical, 4)
                }
            }
        }
            .navigationTitle(viewModel.title)
            .toolbar {
                ToolbarItem(placement: .navigationBarLeading) {
                    Button {
                        print("Настройки нажаты")
                    } label: {
                        Image(systemName: "gearshape")
                    }
                }
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button {
                        print("Добавить новый курс")
                    } label: {
                        Image(systemName: "plus")
                    }
                }
            }
            .refreshable {
                    viewModel.reload()
            }
        }
    }
    
    #Preview {
        ExchangeRateListView()
}
