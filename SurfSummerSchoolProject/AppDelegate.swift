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
            runMainFlow()
        } else {
            // TODO: - Make Auth
            let tempCredentials = AuthRequestModel(phone: "+79876543219", password: "qwerty")
            AuthService().performLoginRequestAndSaveToken(credentials: tempCredentials) { [weak self] result in
                switch result {
                case .success:
                    self?.runMainFlow()
                case .failure:
                    print("no token \(#function)")
                    // TODO: - Handle error, if token was not received
                    break
                }
            }
        }
    }

    func runMainFlow() {
       DispatchQueue.main.async {
            //self.window?.rootViewController = TabBarConfigurator().configure()
           self.window?.rootViewController = AuthorizationViewController()
        }
    }
    
    func runLaunchScreen() {
        let launchScreenViewController = UIStoryboard(name: "LaunchScreen", bundle: .main).instantiateInitialViewController()
        
        window?.rootViewController = launchScreenViewController
    }

}

