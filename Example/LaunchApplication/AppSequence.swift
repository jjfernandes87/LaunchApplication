//
//  AppSequence.swift
//  LaunchApplication_Example
//
//  Created by Julio Fernandes on 23/12/17.
//  Copyright © 2017 CocoaPods. All rights reserved.
//

import UIKit
import LaunchApplication

class AppSequence: LaunchApplication {
    
    /// Metodo responsável por carregar a lista de launch e relaunch
    @objc func launchAndRelaunchSequence() {
        launchSequence.append("LaunchStage_bootOne")
        launchSequence.append("LaunchStage_bootTwo")
        relaunchSequence.append("LaunchStage_bootOne")
        relaunchSequence.append("LaunchStage_bootTwo")
    }
    
    /// Metodo 1 para ser executado
    @objc func bootOne() {
        print("bootOne")
        nextLaunchStage()
    }
    
    /// Metodo 2 para ser executado
    @objc func bootTwo() {
        print("bootTwo")
        nextLaunchStage()
    }
    
}
