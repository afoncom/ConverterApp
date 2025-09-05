//
//  ViewController.swift
//  CurrencyConverter
//
//  Created by afon.com on 04.09.2025.
//

import UIKit

class ViewController: UIViewController {

    private var hasNavigatedToConverter = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Добавим небольшую задержку для плавного перехода
        DispatchQueue.main.asyncAfter(deadline: .now() + 1.0) {
            self.navigateToConverter()
        }
    }
    
    private func navigateToConverter() {
        // Проверяем, что переход еще не был выполнен
        guard !hasNavigatedToConverter else { return }
        hasNavigatedToConverter = true
        
        // Загружаем сториборд
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        
        // Ищем второй экран по Storyboard ID или создаем программно
        let converterVC: CurrencyRatesController
        
        if let storyboardVC = storyboard.instantiateViewController(withIdentifier: "CurrencyRatesController") as? CurrencyRatesController {
            converterVC = storyboardVC
        } else {
            // Если ID не найден, создаем программно
            converterVC = CurrencyRatesController()
        }
        
        
        // Переходим к нему
        if let navController = navigationController {
            navController.pushViewController(converterVC, animated: true)
        } else {
            // Если нет NavigationController, показываем модально
            present(converterVC, animated: true)
        }
    }

}


