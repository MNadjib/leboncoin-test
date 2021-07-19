//
//  AppDelegate.swift
//  Leboncoin
//
//  Created by Nadjib Bellouni on 14/07/2021.
//

import UIKit

@main
class AppDelegate: UIResponder, UIApplicationDelegate {
    
    var window: UIWindow?
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        
        AppAppearances.setupAppearance()
        
        setupNetworkMonitoring()
        
        window = UIWindow(frame: UIScreen.main.bounds)
        let navigationController = UINavigationController()
        window?.rootViewController = navigationController
        
        let classifiedAdsCoordinator = ClassifiedAdsCoordinator(navigationController)
        classifiedAdsCoordinator.start()
        
        window?.makeKeyAndVisible()
        
        return true
    }
    
    private func setupNetworkMonitoring() {
        let _ = NetworkStatus.shared.startMonitoring()
    }
}

