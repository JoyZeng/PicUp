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
            if let url = content as? URL {
                ImgurAPI.post(imageURL: url)
            } else if let data = content as? Data {
                ImgurAPI.post(imageData: data)
            }
        }
    }
}
