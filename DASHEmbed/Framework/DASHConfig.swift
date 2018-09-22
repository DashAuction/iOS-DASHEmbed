//
//  DASHConfig.swift
//  DASHEmbed
//
//  Copyright © 2018 DASH. All rights reserved.
//
//  A DASHConfig instance is used to configure the DASH instance for use.

import Foundation

@objc public class DASHConfig: NSObject {
    
    /// A unique identifier for the DASH Foundation (provided by DASH)
    public let appId: String
    
    /// When true, DASH points to the development servers. Internal use.
    public let useDevelopmentServers: Bool
    
    ///Public initializer
    @objc public init(appId: String, useDevelopmentServers: Bool = false) {
        self.appId = appId
        self.useDevelopmentServers = useDevelopmentServers
        super.init()
    }
}


