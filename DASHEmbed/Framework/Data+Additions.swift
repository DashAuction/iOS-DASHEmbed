//
//  Data+Additions.swift
//  DASHEmbed
//
//  Copyright © 2018 DASH. All rights reserved.
//

import Foundation

extension Data {
    var hexString: String {
        let hexString = map { String(format: "%02.2hhx", $0) }.joined()
        return hexString
    }
}
