//
//  NotificationController.swift
//  PicUp
//
//  Created by Joy on 2018-12-04.
//  Copyright © 2018 Joy Zeng. All rights reserved.
//

import Cocoa

class NotificationCenter: NSObject {
    
    static let shared = NotificationCenter()
    
    func showNotification(withTitle title: String,  informativeText: String) {
        let notification = NSUserNotification()
        notification.identifier = "unique-id"
        notification.title = title
//        notification.subtitle = ""
        notification.informativeText = informativeText
        notification.soundName = NSUserNotificationDefaultSoundName
        NSUserNotificationCenter.default.deliver(notification)
    }
    
}
