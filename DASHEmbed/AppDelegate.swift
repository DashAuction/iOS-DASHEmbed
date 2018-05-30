//
//  AppDelegate.swift
//  DASHEmbed
//
//  Copyright © 2018 DASH. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
        
        //Configure DASH Instance
        let bundleIdentifier = Bundle.main.bundleIdentifier ?? "io.dashapp.DASHEmbed"
        let dashConfig = DASHConfig(teamIdentifier: "fcdallas", distrubutorIdentifier: "DASH_DISTRIBUTOR", applicationIdentifier: bundleIdentifier)
        DASH.team.start(with: dashConfig)
        
        return true
    }

    func application(_ application: UIApplication, didRegisterForRemoteNotificationsWithDeviceToken deviceToken: Data) {
        //Sets the user's push token for outbid notifications
        DASH.team.setUserPushToken(with: deviceToken)
    }
}

