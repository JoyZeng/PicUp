//
//  PasteBoardService.swift
//  PicUp
//
//  Created by Joy on 2018-12-09.
//  Copyright © 2018 Joy Zeng. All rights reserved.
//

import Cocoa

class ClipboardService: NSObject {

    static let shared = ClipboardService()

    func getClipboardImage() -> Any? {
        let supportedImageTypes: [NSPasteboard.PasteboardType] = [.tiff, .png]

        guard let item = NSPasteboard.general.pasteboardItems?.first else {
            return nil
        }
        
        // It is fileURL path
        if let contentPath = item.string(forType: .fileURL) {
            let contentURL = URL(string: contentPath)
            return contentURL
        }
        
        // It is a url string
        if let contentString = item.string(forType: .string) {
            var contentURL: URL? = nil
            if contentString.starts(with: "/") {
                // It is local file path string
                contentURL = URL(fileURLWithPath: contentString)
            } else {
                contentURL = URL(string: contentString)
            }
            return contentURL
        }
        
        for type in item.types{
            // It is image
            if supportedImageTypes.contains(type) {
                if let imageData = item.data(forType: type) {
                    return imageData
                }
            }
        }
        
        return nil
      
    }
    
    func writeToClipboard(content: String) {
        let pasteBoard = NSPasteboard.general
        pasteBoard.clearContents()
        pasteBoard.setString(content, forType: .string)
    }
}
