//
//  CurrencyConverterViewModel.swift
//  CurrencyConverter
//
//  Created by afon.com on 04.09.2025.
//

import Foundation

// MARK: - Currency Converter Delegate Protocol
protocol CurrencyConverterViewModelDelegate: AnyObject {
    func viewModelDidUpdateConversion(_ viewModel: CurrencyConverterViewModel)
    func viewModelDidUpdateSelectedCurrency(_ viewModel: CurrencyConverterViewModel)
    func viewModel(_ viewModel: CurrencyConverterViewModel, didFailWithError error: String)
}

//Контракт для делегата (обычно это ViewController).
//  ViewModel не знает про конкретный UI, но может сказать:
//  «Обновился результат конвертации».
//  «Пользователь сменил валюту».
//  «Произошла ошибка конвертации».

// MARK: - Currency Converter ViewModel
class CurrencyConverterViewModel {
    
    // MARK: - Properties
    weak var delegate: CurrencyConverterViewModelDelegate?
    private let currencyService: CurrencyServiceProtocol
    
//    delegate — слабая ссылка, чтобы избежать retain-цикла.
//    currencyService — зависимость, которая умеет конвертировать валюты (по умолчанию CurrencyService.shared).
    
    // MARK: - Observable Properties
    private(set) var inputAmount: String = "" {
        didSet {
            performConversion()
        }
    }
    
//    Строка, которую вводит пользователь.
//    При каждом изменении сразу пробуем пересчитать конвертацию.
    
    private(set) var selectedCurrency: Currency? {
        didSet {
            performConversion()
            delegate?.viewModelDidUpdateSelectedCurrency(self)
        }
    }
    
//    Выбранная целевая валюта.
//    При изменении — пересчёт и уведомление делегата.
    
    private(set) var conversionResult: ConversionResult? {
        didSet {
            delegate?.viewModelDidUpdateConversion(self)
        }
    }
    
//    Результат пересчёта.
//    Делегат узнаёт, когда готово новое значение.
//    private(set) значит: читать можно извне, а менять — только внутри ViewModel.
    
    
    private let baseCurrency = Currency.usd
    
    // MARK: - Computed Properties
    var hasValidInput: Bool {
        return !inputAmount.isEmpty && Double(inputAmount) != nil && Double(inputAmount)! > 0
    }
//    Проверяет, что введено положительное число.
    
    var displayInputAmount: String {
        guard hasValidInput, let amount = Double(inputAmount) else {
            return "0.00"
        }
        return currencyService.getFormattedAmount(amount, currency: baseCurrency)
    }
//    Возвращает красиво отформатированную сумму ввода (например $123.45).

    
    var displayConvertedAmount: String {
        guard let result = conversionResult else {
            return selectedCurrency != nil ? "Введите сумму" : "Выберите валюту"
        }
        return result.formattedConverted
    }
//    Если уже есть результат — отформатированная сумма.
//    Если нет валюты — «Выберите валюту».
//    Если валюта выбрана, но суммы нет — «Введите сумму».
    
    var displayExchangeRate: String {
        guard let currency = selectedCurrency,
              let rate = currencyService.getRate(from: baseCurrency, to: currency) else {
            return ""
        }
        return "1 USD = \(String(format: "%.4f", rate)) \(currency.code)"
    }
//    Строка с текущим курсом, например 1 USD = 0.8500 EUR.
    
    // MARK: - Initialization
    init(currencyService: CurrencyServiceProtocol = CurrencyService.shared) {
        self.currencyService = currencyService
    }
    
    // MARK: - Public Methods
    func updateInputAmount(_ amount: String) {
        // Очистка строки от нечисловых символов кроме точки
        let cleanedAmount = amount.filter { $0.isNumber || $0 == "." }
        
        // Проверка на корректность числа
        if cleanedAmount.isEmpty {
            inputAmount = ""
            return
        }
        
        // Проверка на множественные точки
        let dotCount = cleanedAmount.filter { $0 == "." }.count
        if dotCount > 1 {
            return // Не обновляем если больше одной точки
        }
        
        inputAmount = cleanedAmount
    }
    
//    Фильтрует ввод: оставляет только цифры и точку.
//    Отбрасывает лишние точки (не даёт ввести два десятичных разделителя).
//    Записывает в inputAmount, что автоматически запускает пересчёт.

    func selectCurrency(_ currency: Currency) {
        selectedCurrency = currency
    }
//    Запоминает выбранную валюту и пересчитывает результат.

    func clearSelection() {
        selectedCurrency = nil
        conversionResult = nil
    }
//    Сбрасывает выбранную валюту и результат.
    // MARK: - Private Methods
    private func performConversion() {
        guard hasValidInput,
              let currency = selectedCurrency,
              let amount = Double(inputAmount) else {
            conversionResult = nil
            return
        }
        
        guard let result = currencyService.convert(
            amount: amount,
            from: baseCurrency,
            to: currency
        ) else {
            delegate?.viewModel(self, didFailWithError: "Ошибка конвертации валюты")
            return
        }
        
        conversionResult = result
    }
    
//    Проверяет, что есть корректный ввод и выбрана валюта.
//    Запрашивает у currencyService пересчёт.
//    Если сервис вернул nil, вызывает делегат с ошибкой.
//    Иначе сохраняет conversionResult, что уведомит делегата об обновлении.
    
    // MARK: - Helper Methods
    func getCurrenciesForSelection() -> [Currency] {
        return currencyService.getCurrenciesForExchange(excluding: baseCurrency)
    }
//    Возвращает список всех валют, кроме USD — чтобы показать их в списке выбора.
    
    
    func getSelectedCurrencyDisplayName() -> String {
        guard let currency = selectedCurrency else {
            return "Выберите валюту"
        }
        return "\(currency.name) (\(currency.code))"
    }
}
//Текст для кнопки/лейбла: «Euro (EUR)» или «Выберите валюту», если ничего не выбрано.
