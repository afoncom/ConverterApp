//
//  ViewController.swift
//  CurrencyConverter
//
//  Created by afon.com on 04.09.2025.
//

import UIKit

class CurrencyRatesController: UIViewController {
    
    @IBOutlet weak var usdDefAmount: UITextField!   // ввод суммы в USD
    
    @IBOutlet weak var currencyEUR: UILabel!        // результат в EUR
    @IBOutlet weak var currencyRUB: UILabel!        // результат в RUB
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Скрытие клавиатуры по тапу
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(hideKeyboard))
        view.addGestureRecognizer(tapGesture)
        
        // Делегат для возврата по Return
        usdDefAmount.delegate = self
    }
    
    @objc private func hideKeyboard() {
        view.endEditing(true)
    }
    
    @objc private func backButtonTapped() {
        navigationController?.popViewController(animated: true)
    }
    
    @IBAction func resultButtonTapped(_ sender: UIButton) {
        // Берём сумму из текстфилда
        let amountText = usdDefAmount.text ?? ""
        let amount = Double(amountText) ?? 0
        
        // Конвертируем в EUR и RUB
        let eurResult = CurrencyRates.convert(amount: amount, from: "USD", to: "EUR")
        let rubResult = CurrencyRates.convert(amount: amount, from: "USD", to: "RUB")
        
        // Обновляем лейблы
        currencyEUR.text = String(format: "%.2f EUR", eurResult)
        currencyRUB.text = String(format: "%.2f RUB", rubResult)
    }
}

// MARK: - UITextFieldDelegate
extension CurrencyRatesController: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder() // скрыть клавиатуру
        return true
    }
}
