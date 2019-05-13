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
            // Retrieve image data
            var imageData: Data? = nil
            var imageType: String? = nil
            if let url = content as? URL {
                imageData = try? Data(contentsOf: url)
                imageType = url.pathExtension
            } else  {
                imageData = content as? Data
            }
            
            // Upload image data
            if let imageData = imageData {
                ImgurAPI.post(imageData: imageData, imageType: imageType) { url, errorMessage in
                    if let url = url {
                        self.successHandler(url: url, imageData: imageData)
                    } else {
                        self.failureHandler(errorMessage: errorMessage!)
                    }
                }
            }
        } else {
            NotificationCenter.shared.showNotification(withTitle: "Not valid image", informativeText: nil, image: nil)
        }
    }
    
    func successHandler(url: String, imageData: Data) {
        ClipboardService.shared.writeToClipboard(content: url)
        NotificationCenter.shared.showNotification(withTitle: "Image link copied to clipboard.", informativeText: url, image: NSImage.init(data: imageData))
    }
    
    func failureHandler(errorMessage: String) {
        NotificationCenter.shared.showNotification(withTitle: "Image upload failed.", informativeText: errorMessage, image: nil)
    }
}
