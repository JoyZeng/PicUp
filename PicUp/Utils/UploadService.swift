//
//  UploadService.swift
//  PicUp
//
//  Created by Joy on 2018-12-09.
//  Copyright © 2018 Joy Zeng. All rights reserved.
//

import Cocoa

class UploadService: NSObject {
    static let shared = UploadService()
    
    func uploadClipboardItem() {
        if let content = ClipboardService.shared.getClipboardImage() {
            var imageData: Data? = nil
            if let url = content as? URL {
                imageData = try? Data(contentsOf: url)
            } else  {
                imageData = content as? Data
            }
            if let data = imageData {
                ImgurAPI.post(imageData: data)
            }
        }
    }
    
    func successHandler(url: String) {
        ClipboardService.shared.writeToClipboard(content: url)
        NotificationCenter.shared.showNotification(withTitle: "Image link copied to clipboard.", informativeText: url, image: nil)
    }
    
    func failureHandler(errorMessage: String) {
        NotificationCenter.shared.showNotification(withTitle: "Image upload failed.", informativeText: errorMessage, image: nil)
    }
}
