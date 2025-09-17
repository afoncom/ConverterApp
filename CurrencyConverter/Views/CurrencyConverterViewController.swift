//
//  CurrencyConverterViewController.swift
//  CurrencyConverter
//
//  Created by afon.com on 04.09.2025.
//

import UIKit
import SwiftUI

class CurrencyConverterViewController: UIViewController {
    
//    Это класс контроллера, который отвечает за экран конвертера валют. Он наследуется от UIViewController.
    
    // MARK: - IBOutlets
    @IBOutlet weak var amountTextField: UITextField!
    @IBOutlet weak var convertedAmountLabel: UILabel!
    @IBOutlet weak var exchangeRateLabel: UILabel!
    @IBOutlet weak var selectCurrencyButton: UIButton!
    
//    amountTextField — поле для ввода суммы в долларах.
//    convertedAmountLabel — лейбл для отображения конвертированной суммы.
//    exchangeRateLabel — лейбл для отображения курса валют.
//    selectCurrencyButton — кнопка для выбора валюты.
    
    // MARK: - Properties
    private var viewModel: CurrencyConverterViewModel!
//    viewModel — модель представления (MVVM), которая содержит логику конвертации валют, хранит текущий курс и выбранную валюту.
    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        setupViewModel()
        setupUI()
        setupDelegates()
    }
    
//    Когда экран загружается, вызываются методы для:
//    Настройки viewModel.
//    Настройки внешнего вида UI.
//    Настройки делегатов (для текстового поля).
    
    // MARK: - Setup Methods
    private func setupViewModel() {
        viewModel = CurrencyConverterViewModel()
        viewModel.delegate = self
    }
    
//    Создаём экземпляр модели представления.
//    Подписываем контроллер на её события через делегат (CurrencyConverterViewModelDelegate), чтобы обновлять UI при изменении данных.
    
    private func setupUI() {
        
        // Настройка текстового поля
        amountTextField.placeholder = "Введите сумму в USD"
        amountTextField.keyboardType = .decimalPad
        amountTextField.borderStyle = .roundedRect
        
        // Настройка кнопки выбора валюты
        selectCurrencyButton.setTitle(viewModel.getSelectedCurrencyDisplayName(), for: .normal)
        selectCurrencyButton.backgroundColor = .systemBlue
        selectCurrencyButton.setTitleColor(.white, for: .normal)
        selectCurrencyButton.layer.cornerRadius = 8
        
        // Настройка лейблов
        updateConversionDisplay()
        updateExchangeRateDisplay()
        
        // Настройка скрытия клавиатуры
        setupKeyboardDismissal()
    }
    
    private func setupDelegates() {
        amountTextField.delegate = self
        amountTextField.addTarget(self, action: #selector(textFieldDidChange), for: .editingChanged)
    }
    
//    Контроллер становится делегатом для UITextField, чтобы управлять вводом и проверкой текста.
//    При изменении текста вызывается textFieldDidChange.
    
    private func setupKeyboardDismissal() {
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(hideKeyboard))
        view.addGestureRecognizer(tapGesture)
    }
    
    // MARK: - Actions
    @IBAction func selectCurrencyButtonTapped(_ sender: UIButton) {
        navigateToExchangeRateList()
    }
//    При нажатии на кнопку выбираем валюту — переходим на экран списка валют.
    
    @objc private func textFieldDidChange() {
        viewModel.updateInputAmount(amountTextField.text ?? "")
    }
//    При изменении текста в поле ввода отправляем значение в viewModel для пересчёта.

    
    @objc private func hideKeyboard() {
        view.endEditing(true)
    }
    
//    Скрываем клавиатуру при тапе вне текстового поля.
    // MARK: - Navigation
    private func navigateToExchangeRateList() {
        let exchangeRateView = ExchangeRateListView(delegate: self)
        let hostingController = UIHostingController(rootView: exchangeRateView)
        hostingController.title = "Выберите валюту"
        navigationController?.pushViewController(hostingController, animated: true)
    }
//    Загружаем экран выбора валют из сториборда и показываем его.
    
    // MARK: - UI Updates
    private func updateConversionDisplay() {
        convertedAmountLabel.text = viewModel.displayConvertedAmount
    }
    
    private func updateExchangeRateDisplay() {
        exchangeRateLabel.text = viewModel.displayExchangeRate
    }
    
    private func updateCurrencyButton() {
        selectCurrencyButton.setTitle(viewModel.getSelectedCurrencyDisplayName(), for: .normal)
    }
    
    private func showError(_ message: String) {
        let alert = UIAlertController(title: "Ошибка", message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .default))
        present(alert, animated: true)
    }
}
//Методы для обновления текста лейблов и кнопки.
//Метод для отображения ошибки пользователю.

// MARK: - UITextFieldDelegate
extension CurrencyConverterViewController: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        // Разрешаем только цифры и одну точку
        let allowedCharacters = CharacterSet(charactersIn: "0123456789.")
        let characterSet = CharacterSet(charactersIn: string)
        
        if !allowedCharacters.isSuperset(of: characterSet) {
            return false
        }
        
        // Проверяем на множественные точки
        let currentText = textField.text ?? ""
        let newText = (currentText as NSString).replacingCharacters(in: range, with: string)
        let dotCount = newText.filter { $0 == "." }.count
        
        return dotCount <= 1
    }
}
//Разрешаем только цифры и одну точку.
//Запрещаем ввод букв и второго разделителя.

// MARK: - Currency Converter ViewModel Delegate
extension CurrencyConverterViewController: CurrencyConverterViewModelDelegate {
    func viewModelDidUpdateConversion(_ viewModel: CurrencyConverterViewModel) {
        DispatchQueue.main.async { [weak self] in
            self?.updateConversionDisplay()
        }
    }
    
    func viewModelDidUpdateSelectedCurrency(_ viewModel: CurrencyConverterViewModel) {
        DispatchQueue.main.async { [weak self] in
            self?.updateCurrencyButton()
            self?.updateExchangeRateDisplay()
        }
    }
    
    func viewModel(_ viewModel: CurrencyConverterViewModel, didFailWithError error: String) {
        DispatchQueue.main.async { [weak self] in
            self?.showError(error)
        }
    }
}
//Когда модель обновляет конвертацию или валюту, мы обновляем UI.
//Если произошла ошибка — показываем алерт.

// MARK: - Exchange Rate Selection Delegate
extension CurrencyConverterViewController: ExchangeRateSelectionDelegate {
    func didSelectCurrency(_ currency: Currency) {
        viewModel.selectCurrency(currency)
        navigationController?.popViewController(animated: true)
    }
}

//После выбора валюты из списка отправляем её в модель для пересчёта
