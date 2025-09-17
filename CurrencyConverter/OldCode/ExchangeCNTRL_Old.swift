//
//  ExchangeRate.swift
//  CurrencyConverter
//
//  Created by afon.com on 11.09.2025.
//


//import UIKit
//
//// Протокол для передачи выбранного курса валют
//protocol ExchangeRateDelegate: AnyObject {
//    func didSelectExchangeRate(currencyCode: String, rate: String)
//}
//
//class ExchangeRateController: UITableViewController {
//    
//    // Delegate для передачи данных обратно
//    weak var delegate: ExchangeRateDelegate?
//    
//    // Данные курсов валют
//    let currencies = [
//        ("EUR", "0.85"),
//        ("RUB", "95.50"),
//        ("GBP", "0.75"),
//        ("CNY", "7.25")
//    ]
//    
//    override func viewDidLoad() {
//        super.viewDidLoad()
//        
////        // Настройка заголовка
//        title = nil
//
//        // Настройка таблицы
//        tableView.backgroundColor = UIColor.systemBackground
//    }
//    
//    // MARK: - Table view data source
//    
//    override func numberOfSections(in tableView: UITableView) -> Int {
//        return 1
//    }
//    
//    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
//        return currencies.count
//    }
//    
//    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
//        let currency = currencies[indexPath.row]
//        
//        // Используем соответствующие reuseIdentifier из storyboard
//        let reuseIdentifiers = ["UER", "RUB", "GBP", "CNY"]
//        let reuseIdentifier = reuseIdentifiers[indexPath.row]
//        
//        let cell = tableView.dequeueReusableCell(withIdentifier: reuseIdentifier, for: indexPath)
//        
//        // Настройка ячейки
//        cell.textLabel?.text = currency.0
//        cell.detailTextLabel?.text = currency.1
//        
//        return cell
//    }
//    
//    // MARK: - Table view delegate
//    
//    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
//        print("💱 Нажата ячейка с индексом: \(indexPath.row)")
//        
//        // Убираем выделение ячейки
//        tableView.deselectRow(at: indexPath, animated: true)
//        
//        // Получаем выбранную валюту
//        let selectedCurrency = currencies[indexPath.row]
//        print("🌍 Выбрана валюта: \(selectedCurrency.0) - \(selectedCurrency.1)")
//        
//        // Проверяем, что delegate установлен
//        if let delegate = delegate {
//            print("✅ Delegate найден, вызываем didSelectExchangeRate")
//            delegate.didSelectExchangeRate(currencyCode: selectedCurrency.0, rate: selectedCurrency.1)
//        } else {
//            print("❌ Delegate не установлен!")
//        }
//        
//        // Возвращаемся к предыдущему экрану
//        navigationController?.popViewController(animated: true)
//    }
//    
//    @objc private func backButtonTapped() {
//        navigationController?.popViewController(animated: true)
//    }
//    
//}
