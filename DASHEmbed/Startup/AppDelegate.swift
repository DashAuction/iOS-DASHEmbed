//
//  AppDelegate.swift
//  DASHEmbed
//
//  Copyright © 2018 DASH. All rights reserved.
//

import UIKit
import UserNotifications

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
        
        //Configure DASH Instance
        let appId = "55e1bb99a1a135543f692bad"
        let dashConfig = DASHConfig(appId: appId)
        //Start DASH
        DASH.team.start(with: dashConfig)
        
        //This is the push token for Pete's iPhone X (for use when in the simulator, overriden by didRegister...)
        DASH.team.setUserPushToken(with: "a7697dc1ecce86fcaba87411eadfeb9c32e2082b9f3458699beacfd0ac7eba00")
        
        return true
    }
    
    // MARK: - Push Delegate

    func application(_ application: UIApplication, didRegisterForRemoteNotificationsWithDeviceToken deviceToken: Data) {
        //Sets the user's push token for outbid notifications
        DASH.team.setUserPushToken(with: deviceToken)
    }
}

