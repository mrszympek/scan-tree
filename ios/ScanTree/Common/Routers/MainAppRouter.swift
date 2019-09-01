//
//  MainAppRouter.swift
//  ScanTree
//
//  Created by Kamil Zajac on 01/09/2019.
//  Copyright © 2019 KamilZając. All rights reserved.
//

import UIKit

protocol MainAppRouter: Router {
    func navigateToSplash()
    func navigateToApp(animated: Bool)
    func navigateToLogin(animated: Bool)
}

extension MainAppRouter where Self: Router {
    
    func navigateToSplash() {
        guard let window = (UIApplication.shared.delegate as? AppDelegate)?.window else {
            return
        }
        let splashVC = UIStoryboard(name: "Authorization", bundle: nil).instantiateViewController(withIdentifier: "SplashViewController")
        window.rootViewController = splashVC
        window.makeKeyAndVisible()
    }
    
    func navigateToApp(animated: Bool) {
        guard let dashboard = UIStoryboard(name: "Dashboard", bundle: nil).instantiateInitialViewController(),
            let window = (UIApplication.shared.delegate as? AppDelegate)?.window else {
                return
        }
        
        func changeRootControllerToApp() {
            window.rootViewController = dashboard
            window.makeKeyAndVisible()
        }
        
        if !animated {
            changeRootControllerToApp()
            return
        }
        
        UIView.transition(with: window, duration: 0.5, options: .transitionFlipFromLeft, animations: {
            changeRootControllerToApp()
        }) { (Bool) in
            log.info("User logged in, redirected to dashboard screens")
        }
    }
    
    func navigateToLogin(animated: Bool) {
        guard let dashboard = UIStoryboard(name: "Authorization", bundle: nil).instantiateInitialViewController(),
            let window = (UIApplication.shared.delegate as? AppDelegate)?.window else {
                return
        }
        
        func changeRootControllerToLogin() {
            window.rootViewController = dashboard
            window.makeKeyAndVisible()
        }
        
        if !animated {
            changeRootControllerToLogin()
            return
        }
        
        UIView.transition(with: window, duration: 0.5, options: .transitionFlipFromRight, animations: {
            changeRootControllerToLogin()
        }) { (Bool) in
            log.info("User logged out, redirected to login screens")
        }
    }
}

class AppRouter: MainAppRouter {
    // Default implementation of main router, used in AppDelegate
}
