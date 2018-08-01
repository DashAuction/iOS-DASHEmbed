//
//  DASH.swift
//  DASHEmbed
//
//  Copyright © 2018 DASH. All rights reserved.
//
//  A DASH instance can be used as an app wide singleton (by using team) or as a local instance (by using
//  the initializer). It is the main class for interacting with the SDK. Use this instance to handle deep
//  link URLs and to instantiate a view controller to show the DASH interface.

import Foundation
import UIKit
import UserNotifications

class DASH {
    
    enum Error {
        case unableToLoad
        case noInternet
    }
    
    private let dashNotificationInfoKey = "dash"
    private let dashPushTokenKey = "io.dashapp.dashembed.pushtoken"
    private let dashUserEmailKey = "io.dashapp.dashembed.useremail"

    struct UserInfo {
        var pushTokenString: String?
        var userEmail: String?
    }
    
    private var config: DASHConfig?
    private var pushTokenString: String?
    private var userEmail: String?
    private var currentNotificationData: [String: Any]?
    private weak var currentDashViewController: DASHViewController?
    
    // MARK: Public
    
    /// Singleton use of DASH
    static let team = DASH()
    
    /// Initializes DASH. Call this once before any other methods.
    func start(with config: DASHConfig) {
        self.config = config
        
        //Populate cached values
        pushTokenString = cachedString(forKey: dashPushTokenKey)
        userEmail = cachedString(forKey: dashUserEmailKey)
    }
    
    /// Sets the current user's email. Email is used to uniquely identify a user in the DASH system. Email is cached locally by DASH for ease of use.
    func setUserEmail(_ userEmail: String?) {
        self.userEmail = userEmail
        cacheString(userEmail, forKey: dashUserEmailKey)
    }
    
    /// Clears out local and cached user email data
    func clearUserEmail() {
        userEmail = nil
        cacheString(nil, forKey: dashUserEmailKey)
    }
    
    /// Used to set the push device token for the current app. Set this with the data returned from the remote notifications delegate method. This is used to send DASH outbid notifications on the team's behalf. Set each time token changes. Token will be cached locally by DASH for ease of use.
    func setUserPushToken(with data: Data?) {
        pushTokenString = data?.hexString
        cacheString(pushTokenString, forKey: dashPushTokenKey)
    }
    
    /// Used to set the push device token for the current app if already in string format. This is used to send DASH outbid notifications on the team's behalf. Set each time token changes. Token will be cached locally by DASH for ease of use.
    func setUserPushToken(with data: String) {
        pushTokenString = data;
        cacheString(pushTokenString, forKey: dashPushTokenKey)
    }
    
    /// Clears out local and cached push tokens in DASH
    func clearPushToken() {
        pushTokenString = nil
        cacheString(nil, forKey: dashPushTokenKey) //Clears from defaults
    }
    
    /// Returns true if the notification passed in should be handled by DASH. If true, you should tell DASH to handle the notification and present the DASH view controller.
    func canHandleNotification(_ notification: UNNotification) -> Bool {
        return notification.request.content.userInfo[dashNotificationInfoKey] != nil
    }
    
    /// Tells DASH to handle the notification. The next presentation of the DASH view controller will handle the notification. If DASH view controller is already presented, this will reload the interface to handle the notification. EX: If a DASH outbid notification is set here, the next presentation will navigate directly to the respective auction item.
    func setNotificationData(from notification: UNNotification) {
        if let dashInfo = notification.request.content.userInfo[dashNotificationInfoKey] as? [String: Any] {
            currentNotificationData = dashInfo
            
            //If we can go ahead and handle the data, handle it then clear it out
            if let dashViewController = currentDashViewController {
                dashViewController.updateNotificationData(with: dashInfo)
                clearNotificationData()
            }
        }
    }
    
    /// Returns whether DASH currently has data as result of a notification (and subsequently DASH view controller should be presented)
    func hasNotificationData() -> Bool {
        return currentNotificationData != nil
    }
    
    /// Clears out the pending notification data provided by handleNotification()
    func clearNotificationData() {
        currentNotificationData = nil
    }
    
    /// Returns a DASH view controller for display. Can be pushed on a navigation stack as is or presented modally when embedded in a UINavigationController
    func dashViewController() -> DASHViewController? {
        guard let config = config else {
            print("DASH must start with config before using DASHViewController")
            return nil
        }
        
        let viewController = DASHViewController.instantiate(with: config, userInfo: UserInfo(pushTokenString: pushTokenString, userEmail: userEmail), notificationData: currentNotificationData)
        currentDashViewController = viewController
        return viewController
    }
    
    // MARK: Private
    
    private func cacheString(_ string: String?, forKey key: String) {
        let userDefaults = UserDefaults.standard
        if let string = string {
            userDefaults.set(string, forKey: key)
        } else {
            userDefaults.removeObject(forKey: key)
        }
    }
    
    private func cachedString(forKey key: String) -> String? {
        let userDefaults = UserDefaults.standard
        return userDefaults.string(forKey: key)
    }
}
