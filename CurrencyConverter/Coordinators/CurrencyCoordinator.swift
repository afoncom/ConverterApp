//
//  CurrencyCoordinator.swift
//  CurrencyConverter
//
//  Created by afon.com on 04.09.2025.
//

import UIKit

// MARK: - Coordinator Protocol
protocol Coordinator: AnyObject {
    var childCoordinators: [Coordinator] { get set }
    var navigationController: UINavigationController { get set }
    
    func start()
}

// MARK: - Currency Coordinator
final class CurrencyCoordinator: Coordinator {
    var childCoordinators = [Coordinator]()
    var navigationController: UINavigationController
    
    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }
    
    func start() {
        showConverterScreen()
    }
    
    
//    Конкретная реализация координатора для «модуля валют».
//    В конструктор передаётся UINavigationController, в котором будут появляться экраны.
//    start() запускает цепочку — здесь сразу открывается главный экран конвертера.
    // MARK: - Navigation Methods
    private func showConverterScreen() {
        let converterVC = CurrencyConverterViewController()
        converterVC.coordinator = self
        navigationController.pushViewController(converterVC, animated: false)
    }
    
    func dismissCurrentScreen() {
        navigationController.popViewController(animated: true)
    }
}

// MARK: - Currency Converter View Controller Extension
extension CurrencyConverterViewController {
    var coordinator: CurrencyCoordinator? {
        get {
            return objc_getAssociatedObject(self, &AssociatedKeys.coordinator) as? CurrencyCoordinator
        }
        set {
            objc_setAssociatedObject(self, &AssociatedKeys.coordinator, newValue, .OBJC_ASSOCIATION_RETAIN_NONATOMIC)
        }
    }
}


// В чистом Swift нельзя добавить «хранимое» свойство в extension,
//  поэтому используется механизм Associated Objects из Objective-C.
// objc_setAssociatedObject «прикрепляет» объект координатора к конкретному экземпляру контроллера.
//Теперь у CurrencyConverterViewController есть вычисляемое свойство coordinator, которое выглядит как обычное, но хранится динамически.

// MARK: - Associated Keys
private struct AssociatedKeys {
    static var coordinator = "coordinator"
}

//Уникальный ключ (строка), чтобы рантайм отличал это свойство от других.
