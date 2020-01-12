//
//  AppDelegate.swift
//  LivePhotos
//
//  Created by Office Mac on 1/12/20.
//  Copyright © 2020 Vinso. All rights reserved.
//

import UIKit

@UIApplicationMain
final class AppDelegate: UIResponder, UIApplicationDelegate {
    
    var window: UIWindow?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        
        setupWindow()
        
        return true
    }

}

// MARK: - Setup methods

private extension AppDelegate {
    
    func setupWindow() {
        let homeViewController = LPHomeViewController(photosService: LPFakeLivePhotosService())
        let rootNavigation = LPBaseNavigationController(rootViewController: homeViewController)
        
        window = UIWindow(frame: UIScreen.main.bounds)
        window!.rootViewController = rootNavigation
        window!.makeKeyAndVisible()
    }
    
}
