//
//  AppDelegate.swift
//  LaunchApplication
//
//  Created by jjfernandes87 on 12/23/2017.
//  Copyright (c) 2017 jjfernandes87. All rights reserved.
//

import UIKit
import LaunchApplication

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate, LaunchApplicationProtocol {

    var window: UIWindow?
    var launchSequence = AppSequence()

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
        
        launchSequence.launchWithDelegate(delegate: self)
        
        return true
    }
    
    func didFinishLaunchSequence(application: LaunchApplication) {
        print("Sucesso")
    }
    
}

