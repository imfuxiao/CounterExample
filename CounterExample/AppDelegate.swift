//
//  AppDelegate.swift
//  CounterExample
//
//  Created by Colin Eberhardt on 04/08/2016.
//  Copyright © 2016 Colin Eberhardt. All rights reserved.
//

import ReSwift
import UIKit

@main
class AppDelegate: UIResponder, UIApplicationDelegate {
  let injectionContainer = AppDependencyContainer()
  var window: UIWindow?

  func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
    let mainVC = injectionContainer.makeMainViewController()

    if window == nil {
      let window = UIWindow()
      window.frame = UIScreen.main.bounds
      window.makeKeyAndVisible()
      window.rootViewController = mainVC
      self.window = window
    }

    return true
  }

}
