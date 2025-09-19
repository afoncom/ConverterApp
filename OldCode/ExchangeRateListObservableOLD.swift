////
////  ExchangeRateListObservable.swift
////  CurrencyConverter
////
////  Created by afon.com on 13.09.2025.
////
//
//import SwiftUI
//
//
//final class ExchangeRateListObservable: ObservableObject, ExchangeRateSelectionDelegate {
//    @Published private(set) var items: [ExchangeRateCellViewModel] = []
//    @Published var title: String = ""
//    
////    @Published — SwiftUI следит за изменениями этих свойств и обновляет View.
////    private(set) — только этот класс может изменять items, но читать его можно извне.
////    items — массив ячеек для отображения (модель представления строки таблицы/списка).
////    title — заголовок экрана, например «Exchange Rates».
////    
//    
//    private let viewModel: ExchangeRateListViewModel
//    weak var parentDelegate: ExchangeRateSelectionDelegate?
//
////    viewModel — «чистая» бизнес-логика (MVVM). Содержит данные и методы для списка.
////    weak var parentDelegate — делегат, которому можно «пробросить» событие выбора валюты выше по цепочке.
//    
//    init(viewModel: ExchangeRateListViewModel = ExchangeRateListViewModel()) {
//        self.viewModel = viewModel
//        self.viewModel.delegate = self
//        reload()
//    }
//
////Перезагрузка данных
//    
//    func reload() {
//        items = (0..<viewModel.numberOfItems).compactMap { viewModel.cellViewModel(at: $0) }
//        title = viewModel.title
//    }
//    
////    Получаем количество элементов из viewModel.numberOfItems.
////    Для каждого индекса вызываем viewModel.cellViewModel(at:), который возвращает модель для строки списка.
////    Присваиваем массив в items и обновляем title.
////    Так список и заголовок становятся готовыми для SwiftUI View.
//
////    Обработка выбора элемента
//    
//    func selectItem(_ index: Int) {
//        viewModel.selectItem(at: index)
//    }
//    
////    Когда пользователь выбирает строку (например, нажимает в SwiftUI List), вызывается этот метод.
////    Он просто «передаёт» выбор во ViewModel, чтобы там уже решали, что делать.
//    // MARK: - ExchangeRateSelectionDelegate (Делегат выбора валюты)
//    func didSelectCurrency(_ currency: Currency) {
//        print("Выбрана валюта: \(currency.code)")
//        parentDelegate?.didSelectCurrency(currency)
//    }
//}
//
////Это реализация протокола ExchangeRateSelectionDelegate, который ViewModel вызывает, когда внутри логики выбранна какая-то валюта.
////Здесь:
////Для отладки печатаем в консоль код валюты.
////Пробрасываем событие «валюта выбрана» выше (в parentDelegate), чтобы родитель (например, экран или координатор) мог отреагировать.
//
