//
//  ViewController.swift
//  CurrencyConverter
//
//  Created by afon.com on 04.09.2025.
//

//import UIKit
//
//class CurrencyRatesController: UIViewController {
//    
//    @IBOutlet weak var usdDefAmount: UITextField!   // ввод суммы в USD
//    
//    @IBOutlet weak var currencyOutgoing: UILabel!        // результат который хотим получить
//    @IBOutlet weak var currency: UILabel!        // курс
//   
//    
//    // Переменные для хранения выбранного курса
//    private var selectedCurrencyCode: String?
//    private var selectedRate: String?
//    
//    override func viewDidLoad() {
//        super.viewDidLoad()
//        
//        // Скрытие клавиатуры по тапу
//        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(hideKeyboard))
//        view.addGestureRecognizer(tapGesture)
//        
//        // Делегат для возврата по Return
//        usdDefAmount.delegate = self
//    }
//    
//    @objc private func hideKeyboard() {
//        view.endEditing(true)
//    }
//    
//    @objc private func backButtonTapped() {
//        navigationController?.popViewController(animated: true)
//    }
//    
//    @IBAction func resultButtonTapped(_ sender: UIButton) {
//        // Переходим к экрану выбора курса валют
//        navigateToExchangeRateController()
//    }
//    
//    private func navigateToExchangeRateController() {
//        print("🚀 Начинаем переход к ExchangeRateController")
//        let storyboard = UIStoryboard(name: "Main", bundle: nil)
//        
//        if let exchangeRateVC = storyboard.instantiateViewController(withIdentifier: "ExchangeRateController") as? ExchangeRateController {
//            print("✅ ExchangeRateController создан успешно")
//            // Устанавливаем delegate
//            exchangeRateVC.delegate = self
//            print("✅ Delegate установлен")
//            
//            // Переходим к контроллеру
//            navigationController?.pushViewController(exchangeRateVC, animated: true)
//        } else {
//            print("❌ Не удалось создать ExchangeRateController")
//        }
//    }
//    
//    private func convertAndDisplayCurrency() {
//        print("📊 Выполняем конвертацию...")
//        
//        // Проверяем наличие labelов
//        print("🆘 Label currencyOutgoing: \(currencyOutgoing != nil ? "найден" : "не найден")")
//        print("🆘 Label currency: \(currency != nil ? "найден" : "не найден")")
//        
//        // Проверяем, что выбран курс валют
//        guard let currencyCode = selectedCurrencyCode, let rateString = selectedRate, let rate = Double(rateString) else {
//            print("❌ Валюта не выбрана, показываем сообщение")
//            // Показываем сообщение, что нужно выбрать курс
//            currencyOutgoing?.text = "Выберите курс"
//            currency?.text = ""
//            return
//        }
//        print("✅ Валюта выбрана: \(currencyCode) - \(rateString)")
//        
//        // Берём сумму из текстфилда
//        let amountText = usdDefAmount.text ?? ""
//        let amount = Double(amountText) ?? 0
//        print("💵 Сумма для конвертации: \(amount) USD")
//        
//        // Вычисляем результат конвертации
//        let result = amount * rate
//        print("💰 Результат: \(result) \(currencyCode)")
//        
//        // Отображаем результат
//        formatter.currencyCode = currencyCode
//        let formattedResult = formatter.string(from: NSNumber(value: result))
//        print("💯 Форматированный результат: \(formattedResult ?? "")")
//        
//        currencyOutgoing?.text = formattedResult
//        currency?.text = "Курс: 1 USD = \(rateString) \(currencyCode)"
//        print("✅ Результат отображен на экране")
//    }
//    
//    private let formatter: NumberFormatter = {
//        let f = NumberFormatter()
//        f.numberStyle = .currency
//        f.minimumFractionDigits = 2
//        f.maximumFractionDigits = 2
//        return f
//    }()
//}
//
//// MARK: - UITextFieldDelegate
//extension CurrencyRatesController: UITextFieldDelegate {
//    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
//        textField.resignFirstResponder() // скрыть клавиатуру
//        return true
//    }
//}
//
//// MARK: - ExchangeRateDelegate
//extension CurrencyRatesController: ExchangeRateDelegate {
//    func didSelectExchangeRate(currencyCode: String, rate: String) {
//        print("💱 Delegate вызван! Валюта: \(currencyCode), курс: \(rate)")
//        
//        // Сохраняем выбранные данные
//        selectedCurrencyCode = currencyCode
//        selectedRate = rate
//        
//        print("💰 Данные сохранены, выполняем конвертацию")
//        // Выполняем конвертацию и отображаем результат
//        convertAndDisplayCurrency()
//    }
//}
