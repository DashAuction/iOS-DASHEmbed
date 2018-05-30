//
//  DASHConfig.swift
//  DASHEmbed
//
//  Copyright © 2018 DASH. All rights reserved.
//
//  A DASHConfig instance is used to configure the DASH instance for use.

import Foundation

public struct DASHConfig {
    
    /// The unique identifier for the team. Provided by DASH. This is used to tailor the experience per team.
    public var teamIdentifier: String
    
    /// A unique identifier for the app distributor implementing DASH in their app. DASH will provide this identifier.
    public var distributorIdentifier: String
    
    /// A unique identifier for the individual application using DASH. For iOS, this is the bundle identifier.
    public var applicationIdentifier: String
}


