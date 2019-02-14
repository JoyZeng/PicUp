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

    var preferencesController: NSWindowController?
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
    
    @IBAction func showPreferences(_ sender: Any) {
        if !(preferencesController != nil) {
            let storyboard = NSStoryboard(name: NSStoryboard.Name("Main"), bundle: nil)
            preferencesController = storyboard.instantiateController(withIdentifier: "preferencesWindow") as? NSWindowController
        }
        
        if (preferencesController != nil) {
            preferencesController!.showWindow(sender)
        }
    }
    
    func constructStatusButton() {
        if let button = statusItem.button {
            button.image = NSImage(named: NSImage.Name("StatusBarButtonImage"))
        }
    }
    
    func constructMenu() {
        let menu = NSMenu()
        
        menu.addItem(NSMenuItem(title: "Preferences", action: #selector(AppDelegate.showPreferences(_:)), keyEquivalent: "P"))
        menu.addItem(NSMenuItem.separator())
        menu.addItem(NSMenuItem(title: "Quit", action: #selector(NSApplication.terminate(_:)), keyEquivalent: "q"))
        
        statusItem.menu = menu
    }
}

