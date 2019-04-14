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
    
    func showNotification(withTitle title: String,  informativeText: String?, image: NSImage?) {
        let notification = NSUserNotification()
        notification.identifier = Bundle.main.bundleIdentifier
        notification.title = title
        notification.informativeText = informativeText
        notification.soundName = NSUserNotificationDefaultSoundName
        notification.contentImage = image
        NSUserNotificationCenter.default.removeDeliveredNotification(notification)
        NSUserNotificationCenter.default.deliver(notification)
    }
    
    func userNotificationCenter(_ center: NSUserNotificationCenter, shouldPresent notification: NSUserNotification) -> Bool {
        return true
    }
    
    func userNotificationCenter(_ center: NSUserNotificationCenter, didActivate notification: NSUserNotification) {
        if let text = notification.informativeText, let url = URL(string: text) {
            NSWorkspace.shared.open(url)
        }
        
    }
    
}
