//
//  DASHConfig.swift
//  DASHEmbed
//
//  Copyright © 2018 DASH. All rights reserved.
//
//  A DASHConfig instance is used to configure the DASH instance for use.

import Foundation

public struct DASHConfig {
    
    /// A unique identifier for the DASH Foundation (provided by DASH)
    public var appId: String
    
    /// When true, DASH points to the development servers. Internal use.
    var useDevelopmentServers: Bool
    
    ///Public initializer
    public init(appId: String, useDevelopmentServers: Bool = false) {
        self.appId = appId
        self.useDevelopmentServers = useDevelopmentServers
    }
}


