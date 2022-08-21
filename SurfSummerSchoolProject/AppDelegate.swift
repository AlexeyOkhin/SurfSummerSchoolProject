//
//  AppDelegate.swift
//  SurfSummerSchoolProject
//
//  Created by Djinsolobzik on 03.08.2022.
//

import UIKit

@main
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?
    var tokenStorage: TokenStorage {
        BaseTokenStorage()
    }

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        window = UIWindow(frame: UIScreen.main.bounds)
        window?.makeKeyAndVisible()
        if #available(iOS 13.0, *) {
            window?.overrideUserInterfaceStyle = .light
        }
        startApplicationProccess()
        
        return true
    }
    
    func startApplicationProccess() {
        runLaunchScreen()
        
        if let tokenContainer = try? tokenStorage.getToken(), !tokenContainer.isExpired {
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.8) { [weak self] in
                self?.runMainFlow()
            }
        } else {
            
            self.window?.rootViewController = AuthViewController()
            
        }
    }

    func runMainFlow() {
        self.window?.rootViewController = TabBarConfigurator().configure()
    }
    
    func runLaunchScreen() {
        let launchScreenViewController = UIStoryboard(name: "LaunchScreen", bundle: .main).instantiateInitialViewController()
        
        window?.rootViewController = launchScreenViewController
    }

}

