//
//  recording.swift
//  speedometer
//
//  Created by namik kaya on 12.08.2018.
//  Copyright © 2018 namik kaya. All rights reserved.
//

import Foundation


struct recording {
    static private var statusHolder:Bool = false
    static var status:Bool {
        get{
            return statusHolder
        }set{
            statusHolder = newValue
            NotificationCenter.default.post(name: NSNotification.Name(rawValue: staticName.app_record_status), object: nil)
        }
    }
}
