//
//  AppDelegate.swift
//  NoteApp
//
//  Created by seo on 2017. 5. 20..
//  Copyright © 2017년 seoju. All rights reserved.
//

import UIKit
import SnapKit
import RealmSwift

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?


    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
        
        let window: UIWindow = UIWindow(frame: UIScreen.main.bounds)
        window.backgroundColor = .white
        window.makeKeyAndVisible()
        
        let mainViewController: MainViewController = MainViewController()
        let navicationViewController: UINavigationController = UINavigationController(rootViewController: mainViewController)
        window.rootViewController = navicationViewController
        self.window = window
        
        return true
    }
}

