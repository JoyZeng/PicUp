//
//  ShortcutController.swift
//  PicUp
//
//  Created by Joy on 2018-12-08.
//  Copyright © 2018 Joy Zeng. All rights reserved.
//

import Cocoa
import HotKey

class ShortcutService: NSObject {
    static let shared = ShortcutService()

    var uploadHotKey: HotKey?
    
    func register() {
        registerUpload()
    }
    
    private func registerUpload() {
        // Command + Option + V
        uploadHotKey = HotKey(key: .v, modifiers: [.command, .option])
        uploadHotKey!.keyDownHandler = {
            UploadService.shared.uploadClipboardItem()
        }
    }
    
}
