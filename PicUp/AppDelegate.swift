//
//  AppDelegate.swift
//  PicUp
//
//  Created by Joy on 2018-11-28.
//  Copyright © 2018 Joy Zeng. All rights reserved.
//

import Cocoa

@NSApplicationMain
class AppDelegate: NSObject, NSApplicationDelegate {

    let statusItem = NSStatusBar.system.statusItem(withLength: NSStatusItem.squareLength)

    func applicationDidFinishLaunching(_ aNotification: Notification) {
        constructStatusButton()
        constructMenu()
        NSUserNotificationCenter.default.delegate = NotificationCenter.shared
        ShortcutService.shared.register()
    }

    func applicationWillTerminate(_ aNotification: Notification) {
        // Insert code here to tear down your application
    }
    
    @objc func showPreference(_ sender: Any?) {
        print("Show preference")
    }
    
    func constructStatusButton() {
        if let button = statusItem.button {
            button.image = NSImage(named: NSImage.Name("StatusBarButtonImage"))
        }
    }
    
    func constructMenu() {
        let menu = NSMenu()
        
        menu.addItem(NSMenuItem(title: "Preferences", action: #selector(AppDelegate.showPreference(_:)), keyEquivalent: "P"))
        menu.addItem(NSMenuItem.separator())
        menu.addItem(NSMenuItem(title: "Quit", action: #selector(NSApplication.terminate(_:)), keyEquivalent: "q"))
        
        statusItem.menu = menu
    }
}

