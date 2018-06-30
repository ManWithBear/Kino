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

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
        let window = UIWindow(frame: UIScreen.main.bounds)
        window.rootViewController = dummySearch()
        window.makeKeyAndVisible()
        self.window = window
        return true
    }

    func dummySearch() -> UIViewController {
        return SearchViewController(DummySearchViewModel())
        let flow = SearchFlow(
            onItemSelection: { print("Did select item with title: \($0.title ?? "<- No title ->")") }
        )
        return SearchFactoryImpl(.init(search: DummyMovieSearchProvider()))
            .make(with: flow)
    }
}
