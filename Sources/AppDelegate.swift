//
//  AppDelegate.swift
//  Kino
//
//  Created by Denis Bogomolov on 28/06/2018.
//  Copyright © 2018 kino. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?
    var mainFlow: FlowCoordinator?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
        let networker = Networker(apiKey: Configurations.moviedbApiKey, session: URLSession.shared)
        let searchFactory = SearchFactoryImpl(.init(search: networker))
        let flow = SearchFlowCoordinatorImpl(.init(searchFactory: searchFactory))
        mainFlow = flow

        let window = UIWindow(frame: UIScreen.main.bounds)
        window.rootViewController = flow.startFlow()
        window.makeKeyAndVisible()
        self.window = window
        return true
    }
}
