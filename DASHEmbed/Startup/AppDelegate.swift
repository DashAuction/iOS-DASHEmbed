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
        let appId: String
        #if EMBED
        appId = "55e1bb99a1a135543f692bad"
        #else
        appId = "595c4a47c96546377fe4edd0"
        #endif
        let dashConfig = DASHConfig(appId: appId)
        //Start DASH
        DASH.team.start(with: dashConfig)
        
        //Set delegate to respond to push notifications
        UNUserNotificationCenter.current().delegate = self
        
        return true
    }
    
    // MARK: - Push Delegate

    func application(_ application: UIApplication, didRegisterForRemoteNotificationsWithDeviceToken deviceToken: Data) {
        //Sets the user's push token for outbid notifications
        DASH.team.setUserPushToken(with: deviceToken)
    }
}

extension AppDelegate: UNUserNotificationCenterDelegate {
    func userNotificationCenter(_ center: UNUserNotificationCenter, didReceive response: UNNotificationResponse, withCompletionHandler completionHandler: @escaping () -> Void) {
        if DASH.team.canHandleNotification(response.notification) {
            DASH.team.setNotificationData(from: response.notification)
            
            //This is a simplified approach as an example. Exact implementation will depend on your architecture
            if let navController = window?.rootViewController as? UINavigationController, let exampleViewController = navController.topViewController as? ExampleViewController {
                exampleViewController.showDASHIfNeeded()
            }
        }
        
        //Else, Handle other notifications
        
        completionHandler()
    }
    
    func userNotificationCenter(_ center: UNUserNotificationCenter, willPresent notification: UNNotification, withCompletionHandler completionHandler: @escaping (UNNotificationPresentationOptions) -> Void) {
        completionHandler(.alert) //We always want to show the alert to allow for in moment notifications while app is foregrounded
    }
}
