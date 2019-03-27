//
//  SMMSAPI.swift
//  PicUp
//
//  Created by Joy on 2018-12-05.
//  Copyright © 2018 Joy Zeng. All rights reserved.
//

import Foundation
import Alamofire
import SwiftyJSON
import AppKit

// API doc: https://sm.ms/doc/
class SMMSAPI: NSObject, UploadProtocol {
    static func post(imageData: Data, imageType: String?, completionHandler: @escaping (_ url: String?, _ errorMessage: String?) -> Void) {
        AF.upload(
            multipartFormData: { multipartFormData in
                let imageType = imageType ?? "png"
                multipartFormData.append(imageData, withName: "smfile", fileName: "image.\(imageType)", mimeType: "image/\(imageType)")
            },
            to: Constants.SMMS.url)
            .response { response in
                switch response.result {
                case .success(let value):
                    parse(value: value!) { url, errorMessage in
                        completionHandler(url, errorMessage)
                    }
                case .failure(let error):
                    completionHandler(nil, "failed")
                    print("error:\(error)")
                }
        }
    }
    
    static func parse(value: Data, completionHandler: (_ url: String?, _ errorMessage: String?) -> Void) {
        let json = JSON(value)
        let code = json["code"].string
        if code == "success" {
            if let url = json["data"]["url"].string {
                completionHandler(url, nil)
            }
        } else if code == "error" {
            if let msg = json["msg"].string {
                completionHandler(nil, "failed")
                print("Upload to smms failed: \(msg)")
            }
        }
    }
}
