//
//  NotificationController.swift
//  PicUp
//
//  Created by Joy on 2018-12-04.
//  Copyright © 2018 Joy Zeng. All rights reserved.
//

import Cocoa

class NotificationCenter: NSObject, NSUserNotificationCenterDelegate {
    
    static let shared = NotificationCenter()
    
    func showNotification(withTitle title: String,  informativeText: String) {
        let notification = NSUserNotification()
        notification.identifier = "me.zengyi.PicUp"
        notification.title = title
        notification.informativeText = informativeText
        notification.soundName = NSUserNotificationDefaultSoundName
        NSUserNotificationCenter.default.removeDeliveredNotification(notification)
        NSUserNotificationCenter.default.deliver(notification)
    }
    
    func userNotificationCenter(_ center: NSUserNotificationCenter, shouldPresent notification: NSUserNotification) -> Bool {
        return true
    }
    
}
