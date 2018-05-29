//
//  DASHConfig.swift
//  DASHEmbed
//
//  Copyright © 2018 DASH. All rights reserved.
//
//  A DASHConfig instance is used to configure the DASH instance for use.

import Foundation

public struct DASHConfig {
    
    /// An identifier used to uniquely identifiy a user in the DASH system.
    public var userEmail: String
    
    /// The unique identifier for the team. Provided by DASH. This is used to tailor the experience per team.
    public var teamIdentifier: String
    
    /// The push device token for the current app. Set this with the data returned from the remote notifications delegate method. This is used to send DASH outbid notifications on the team's behalf.
    public var pushDeviceToken: Data?
    
    /// A unique identifier for the app distributor implementing DASH in their app. DASH will provide this identifier.
    public var distrubutorIdentifier: String
    
    /// A unique identifier for the individual application using DASH. For iOS, this is the bundle identifier.
    public var applicationIdentifier: String
}


