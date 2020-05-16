//
//  AppDelegate.swift
//  Pongmates
//
//  Created by Vladislav Kulikov on 13.05.2020.
//  Copyright © 2020 Vladislav Kulikov. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        AdMob.shared.start()
        IAPService.shared.addObserver()
        
        return true
    }
    
    func applicationWillTerminate(_ application: UIApplication) {
        IAPService.shared.removeObserver()
    }

}
