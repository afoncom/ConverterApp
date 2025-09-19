//
//  AppDelegate.swift
//  CurrencyConverter
//
//  Created by afon.com on 04.09.2025.
//

import SwiftUI
import CoreData



//
//final class AppDelegate: UIResponder, UIApplicationDelegate {
//
//
//
//    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
//        // Вызывается один раз при запуске приложения.
////        Здесь можно настроить сервисы (например, аналитика, Firebase и т.д.).
////        Сейчас метод просто возвращает true, значит, приложение стартует без дополнительной логики.
//        return true
//    }
//
//    // MARK: UISceneSession Lifecycle
//
//    func application(_ application: UIApplication, configurationForConnecting connectingSceneSession: UISceneSession, options: UIScene.ConnectionOptions) -> UISceneConfiguration {
////        Работает в системе с многими сценами (iPadOS, многозадачность).
////        Возвращает конфигурацию, которая говорит iOS, как создавать новое «окно» (Scene).
////        Здесь выбран стандартный вариант "Default Configuration".
//        return UISceneConfiguration(name: "Default Configuration", sessionRole: connectingSceneSession.role)
//    }
//
//    func application(_ application: UIApplication, didDiscardSceneSessions sceneSessions: Set<UISceneSession>) {
////        Срабатывает, когда пользователь или система закрыли одно из окон (сцен).
////        Можно освободить ресурсы, связанные с этими сценами.
//    }
//
//    // MARK: - Core Data stack
//
//    lazy var persistentContainer: NSPersistentContainer = {
//        /*
//         The persistent container for the application. This implementation
//         creates and returns a container, having loaded the store for the
//         application to it. This property is optional since there are legitimate
//         error conditions that could cause the creation of the store to fail.
//        */
//        let container = NSPersistentContainer(name: "CurrencyConverter")
//        container.loadPersistentStores(completionHandler: { (storeDescription, error) in
//            if let error = error as NSError? {
////                NSPersistentContainer — «контейнер» Core Data, который объединяет:
////                модель данных (CurrencyConverter.xcdatamodeld);
////                Persistent Store — реальный файл базы данных (обычно SQLite).
////                lazy — контейнер создаётся только при первом обращении, а не сразу при запуске.
////                loadPersistentStores — загружает или создаёт файл БД на диске.
////                Если что-то пошло не так (нет прав, нехватка памяти, несовместимость модели), код вызывает fatalError, чтобы сразу увидеть проблему во время разработки.
//                fatalError("Unresolved error \(error), \(error.userInfo)")
//            }
//        })
//        return container
//    }()
//
//    // MARK: - Core Data Saving support
//
//    func saveContext () {
//        let context = persistentContainer.viewContext
//        if context.hasChanges {
//            do {
//                try context.save()
//            } catch {
////                viewContext — главный контекст Core Data, с которым вы работаете в UI.
////                Проверяется, есть ли несохранённые изменения (hasChanges), и если есть, выполняется save().
////                Ошибки при сохранении также приводят к fatalError (это ок для разработки, но в релизе нужно обрабатывать аккуратнее, например, показать сообщение пользователю).
//                let nserror = error as NSError
//                fatalError("Unresolved error \(nserror), \(nserror.userInfo)")
//            }
//        }
//    }
//
//}
//
