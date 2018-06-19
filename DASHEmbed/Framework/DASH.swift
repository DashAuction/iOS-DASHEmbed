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

/// Called when a process completes with success state.
public typealias DASHCompletion = (Bool) -> Void

public class DASH {
    
    struct UserInfo {
        var pushTokenString: String?
        var userEmail: String?
    }

    // MARK: Private
    
    private var config: DASHConfig?
    private var pushTokenString: String?
    private var userEmail: String?
    
    // MARK: Public
    
    /// Singleton use of DASH
    public static let team = DASH()
    
    /// Initializer to make a local instance of the DASH embedded framework
    public init() {
        
    }
    
    /// Initializes DASH. Call this once before any other methods.
    public func start(with config: DASHConfig) {
        self.config = config
    }
    
    /// Sets the current user's email. Email is used to uniquely identify a user in the DASH system.
    public func setUserEmail(_ userEmail: String?) {
        self.userEmail = userEmail
    }
    
    /// Used to set the push device token for the current app. Set this with the data returned from the remote notifications delegate method. This is used to send DASH outbid notifications on the team's behalf.
    public func setUserPushToken(with data: Data?) {
        pushTokenString = data?.hexString
    }
    
    /// Returns true if the url passed in should be handled by DASH. Ex: URLs from DASH notifications will return true. **Not yet implemented. Returns false for now**
    public func canHandleDASHLink(with url: URL) -> Bool {
        return false //Not yet implemented
    }
    
    /// Tells DASH to handle the link. Completion is called once navigation has finished and is ready for display. Ex: DASH will navigate to the correct auction item when passed the URL from an outbid notification. **Not yet implemented. Immediately returns false for now**
    public func handleDASHLink(with url: URL, completion: @escaping DASHCompletion) {
        completion(false) //Not yet implemented
    }
    
    /// Returns a DASH view controller for display. Can be pushed on a navigation stack as is or presented modally when embedded in a UINavigationController
    public func dashViewController() -> UIViewController {
        guard let config = config else {
            fatalError("DASH must start with config before using DASHViewController")
        }
        
        let viewController = DASHViewController.instantiate(with: config, userInfo: UserInfo(pushTokenString: pushTokenString, userEmail: userEmail))
        return viewController
    }
}
