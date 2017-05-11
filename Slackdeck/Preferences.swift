//
//  Preferences.swift
//  Slackdeck
//
//  Created by mzp on 2017/04/29.
//  Copyright © 2017 mzp. All rights reserved.
//

import Foundation

fileprivate let defaults = UserDefaults.standard
fileprivate let kUrls = "urls"

struct Preferences {
    private static func save(object: AnyObject?, forKey key: String) {
        defaults.set(object, forKey: key)
        defaults.synchronize()
    }

    static var urls: [[String]] {
        get { return (defaults.array(forKey: kUrls) as? [[String]]) ?? [] }
        set { save(object: newValue as AnyObject, forKey: kUrls) }
    }
}
