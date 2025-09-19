//
////  SceneDelegate.swift
////  CurrencyConverter
////
////  Created by afon.com on 04.09.2025.
////
//
//import UIKit
//
//final class SceneDelegate: UIResponder, UIWindowSceneDelegate {
//
//    var window: UIWindow?
//    
////    UIResponder — базовый класс, реагирующий на события (жесты, клавиатура и т.д.).
////    UIWindowSceneDelegate — протокол, который получает события жизненного цикла конкретной сцены.
////    window — главное окно (UIWindow) этой сцены, в котором отображается интерфейс.
//
//
//    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
//        // Вызывается, когда система создает новое окно (сцену).
////        Здесь вы создаёте и настраиваете UIWindow, чтобы в нем показать первый экран приложения.
//        guard let windowScene = (scene as? UIWindowScene) else { return }
//        
////        Проверяем, что scene действительно типа UIWindowScene (нужно для работы с окном).
//        
//        // Настраиваем NavigationController для плавных переходов
//        window = UIWindow(windowScene: windowScene)
//        
//        let storyboard = UIStoryboard(name: "Main", bundle: nil)
//        if let initialViewController = storyboard.instantiateInitialViewController() {
//            let navigationController = UINavigationController(rootViewController: initialViewController)
//            navigationController.navigationBar.prefersLargeTitles = true
//            
//            window?.rootViewController = navigationController
//            window?.makeKeyAndVisible()
//        }
//    }
//
//    func sceneDidDisconnect(_ scene: UIScene) {
//        // Called as the scene is being released by the system.
//        // This occurs shortly after the scene enters the background, or when its session is discarded.
//        // Release any resources associated with this scene that can be re-created the next time the scene connects.
//        // The scene may re-connect later, as its session was not necessarily discarded (see `application:didDiscardSceneSessions` instead).
//        
////        Сцена была уничтожена (пользователь закрыл окно).
////        Освобождают ресурсы.
//    }
//
//    func sceneDidBecomeActive(_ scene: UIScene) {
//        // Called when the scene has moved from an inactive state to an active state.
//        // Use this method to restart any tasks that were paused (or not yet started) when the scene was inactive.
////        Сцена снова стала активной (на экране).
////        Перезапускают задачи, которые приостанавливали.
//        
//    }
//
//    func sceneWillResignActive(_ scene: UIScene) {
//        // Called when the scene will move from an active state to an inactive state.
//        // This may occur due to temporary interruptions (ex. an incoming phone call).
//        
////        Сцена уходит в неактивное состояние (например, входящий звонок).
////        Приостанавливают анимации, таймеры.
//        
//    }
//
//    func sceneWillEnterForeground(_ scene: UIScene) {
//        // Called as the scene transitions from the background to the foreground.
//        // Use this method to undo the changes made on entering the background.
////        Переход из фона на экран.
////        Обновляют данные интерфейса.
//        
//    }
//
//    func sceneDidEnterBackground(_ scene: UIScene) {
//        // Called as the scene transitions from the foreground to the background.
//        // Use this method to save data, release shared resources, and store enough scene-specific state information
//        // to restore the scene back to its current state.
//        
//        ////        Сцена ушла в фон.
//        //        Сохраняют данные, останавливают ресурсоёмкие процессы.
//        
//        
//        // Save changes in the application's managed object context when the application transitions to the background.
//        (UIApplication.shared.delegate as? AppDelegate)?.saveContext()
//        
//        //        При уходе в фон вызывается saveContext() из AppDelegate, чтобы сохранить изменения в Core Data.
//        
//    }
//}
//
