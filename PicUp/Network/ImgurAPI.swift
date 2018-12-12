//
//  ImgurAPI.swift
//  PicUp
//
//  Created by Joy on 2018-12-02.
//  Copyright © 2018 Joy Zeng. All rights reserved.
//

import Foundation
import Alamofire
import SwiftyJSON
import AppKit

class ImgurAPI: NSObject {

    static func post(imageURL: URL) {
        let imageData = try? Data(contentsOf: imageURL)
        if let data = imageData {
            post(imageData: data)
        }
        
    }
    
    static func post(imageData: Data) {
        Alamofire.upload(multipartFormData: { multipartFormData in
            multipartFormData.append(imageData, withName: "image")
        }, to: Constants.Imgur.url, method: .post, headers: ["Authorization": "Client-ID \(Constants.Imgur.clientId)"],
           encodingCompletion: { encodingResult in
            switch encodingResult {
            case .success(let upload, _, _):
                upload.responseJSON { response in
                    if let result = response.data {
                        do {
                            let json = try JSON(data: result)
                            let success = json["success"].boolValue
                            if success {
                                if let url = json["data"]["link"].string {
                                    ClipboardService.shared.writeToClipboard(content: url)
                                    NotificationCenter.shared.showNotification(withTitle: "Image link copied.", informativeText: url)
                                }
                            } else {
                                print("Upload to Imgur failed. \(json)")
                            }
                        } catch {
                            print("Not a valid json.")
                        }
                    }
                }
            case .failure(let encodingError):
                print("error:\(encodingError)")
            }
        })
    }
}
