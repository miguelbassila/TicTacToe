//
//  AppDelegate.swift
//  TicTacToe
//
//  Created by Miguel Bassila on 23/11/16.
//  Copyright © 2016 Miguel Bassila. All rights reserved.
//

import UIKit
import Katana

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

  var window: UIWindow?
  var renderer: Renderer?

  func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {

    self.window = UIWindow(frame: UIScreen.main.bounds)
    self.window?.rootViewController = UIViewController()
    self.window?.makeKeyAndVisible()

    let view = self.window!.rootViewController!.view!

    var props = EmptyProps()
    props.frame = UIScreen.main.bounds
    let app = App(props: props)

    self.renderer = Renderer(rootDescription: app, store: nil)
    self.renderer?.render(in: view)

    return true
  }
}
