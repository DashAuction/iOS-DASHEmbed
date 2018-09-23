//
//  Bundle+Additions.swift
//  DASHEmbed
//
//  Created by Ryan Gant on 8/3/18.
//  Copyright © 2018 DASH. All rights reserved.
//

import Foundation

extension Bundle {
    
    static var frameworkResourceBundle: Bundle {
        #if FRAMEWORK
        let currentBundle = Bundle.main
        #else
        let currentBundle = Bundle(for: DASH.self)
        #endif
        let bundleURL = currentBundle.url(forResource: "DASHEmbed", withExtension: "bundle")
        
        guard let url = bundleURL, let resourceBundle = Bundle(url: url) else { fatalError() }
        
        return resourceBundle
    }
}
