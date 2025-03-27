//
//  AppDelegate.swift
//  ITRootsTask
//
//  Created by Ann on 25/03/2025.
//

import UIKit
import CoreData
import IQKeyboardManagerSwift

@main
class AppDelegate: UIResponder, UIApplicationDelegate {
    
    var window: UIWindow?
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
       
        restartApp()
        UIApplication.shared.windows.forEach { window in
            window.overrideUserInterfaceStyle = .light
        }
        
//        IQKeyboardManager.shared.enable = true
        IQKeyboardManager.shared.resignOnTouchOutside = true
        IQKeyboardManager.shared.toolbarConfiguration.tintColor = UIColor.black
        IQKeyboardManager.shared.keyboardConfiguration.overrideAppearance = true
        IQKeyboardManager.shared.toolbarConfiguration.doneBarButtonConfiguration = .init(title: "Done".localized)
        
        return true
        
    }
    
    func restartApp() {
        AppLocalizer.DoTheMagic()
        
        window = UIWindow(frame: UIScreen.main.bounds)
        
        if let userName = UserDefaults.standard.string(forKey: "savedUserName"),
           let password = UserDefaults.standard.string(forKey: "savedPassword"),
           !userName.isEmpty, !password.isEmpty {
            
            let mainTabBarController = MainTabBarController()
            window?.rootViewController = mainTabBarController
            
        } else {
            let loginVC = LoginViewController(nibName: "LoginViewController", bundle: nil)
            let navigationController = UINavigationController(rootViewController: loginVC)
            window?.rootViewController = navigationController
        }
        
        window?.makeKeyAndVisible()
    }

    
    func initWindow(userInfo: [AnyHashable: Any]?, isServey: Bool?, surveyID: String?) {
        UIApplication.setRoot(LoginViewController(), animated: false)
    }
    // MARK: - Core Data stack
    
    lazy var persistentContainer: NSPersistentContainer = {
        /*
         The persistent container for the application. This implementation
         creates and returns a container, having loaded the store for the
         application to it. This property is optional since there are legitimate
         error conditions that could cause the creation of the store to fail.
         */
        let container = NSPersistentContainer(name: "ITRootsTask")
        container.loadPersistentStores(completionHandler: { (storeDescription, error) in
            if let error = error as NSError? {
                // Replace this implementation with code to handle the error appropriately.
                // fatalError() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
                
                /*
                 Typical reasons for an error here include:
                 * The parent directory does not exist, cannot be created, or disallows writing.
                 * The persistent store is not accessible, due to permissions or data protection when the device is locked.
                 * The device is out of space.
                 * The store could not be migrated to the current model version.
                 Check the error message to determine what the actual problem was.
                 */
                fatalError("Unresolved error \(error), \(error.userInfo)")
            }
        })
        return container
    }()
    
    // MARK: - Core Data Saving support
    
    func saveContext () {
        let context = persistentContainer.viewContext
        if context.hasChanges {
            do {
                try context.save()
            } catch {
                // Replace this implementation with code to handle the error appropriately.
                // fatalError() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
                let nserror = error as NSError
                fatalError("Unresolved error \(nserror), \(nserror.userInfo)")
            }
        }
    }
    
}

