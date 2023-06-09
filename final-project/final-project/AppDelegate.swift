//
//  AppDelegate.swift
//  final-project
//
//  Created by User03 on 2023/5/31.
//

import UIKit
import Firebase


class AppDelegate: NSObject, UIApplicationDelegate {
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey : Any]? = nil) -> Bool {
        
        FirebaseApp.configure()
        

        return true
    }
    
}
