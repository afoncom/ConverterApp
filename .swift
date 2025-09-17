//
//  ExchangeRateListView.swift
//  CurrencyConverter
//
//  Created by afon.com on 13.09.2025.
//


struct ExchangeRateListView: View {
    @StateObject private var observable = ExchangeRateListObservable()

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
                }
            }
            .navigationTitle(observable.title)
            .refreshable {
                observable.reload()
            }
        }
    }
}
