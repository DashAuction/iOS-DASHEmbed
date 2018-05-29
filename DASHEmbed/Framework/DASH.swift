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

    // MARK: Private
    
    private var config: DASHConfig?
    
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
        
        let viewController = DASHViewController.instantiate(with: config)
        return viewController
    }
}
