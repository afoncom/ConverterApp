//
//  ExchangeRateListView.swift
//  CurrencyConverter
//
//  Created by afon.com on 13.09.2025.
//

import SwiftUI


struct ExchangeRateListView: View {
    @StateObject private var observable = ExchangeRateListObservable()
    weak var delegate: ExchangeRateSelectionDelegate?
    
    init(delegate: ExchangeRateSelectionDelegate? = nil) {
        self.delegate = delegate
    }
    
    var body: some View {
        NavigationView {
            List(observable.items.indices, id: \.self) { index in
                let item = observable.items[index]
                Button {
                    observable.selectItem(index)
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
            .navigationTitle(observable.title)
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
                    observable.reload()
            }
        }
        .onAppear {
            observable.parentDelegate = delegate
        }
    }
}
    
    #Preview {
        ExchangeRateListView()
}
