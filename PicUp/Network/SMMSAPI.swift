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

class SMMSAPI: NSObject {
    static func post(imageData: Data, imageType: String?, completionHandler: @escaping (_ url: String?, _ errorMessage: String?) -> Void) {
        Alamofire.upload(multipartFormData: { multipartFormData in
            let imageType = imageType ?? "png"
            multipartFormData.append(imageData, withName: "smfile", fileName: "image.\(imageType)", mimeType: "image/\(imageType)")
            }, to: Constants.SMMS.url,
               encodingCompletion: { encodingResult in
                switch encodingResult {
                case .success(let upload, _, _):
                    upload.responseJSON { response in
                        parse(response: response) { url, errorMessage in
                            completionHandler(url, errorMessage)
                        }
                    }
                case .failure(let encodingError):
                    completionHandler(nil, "failed")
                    print("error:\(encodingError)")
                }
        })
    }
    
    static func parse(response: DataResponse<Any>, completionHandler: (_ url: String?, _ errorMessage: String?) -> Void) {
        if let result = response.data {
            do {
                let json = try JSON(data: result)
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
            } catch {
                print("Response is not a valid json.")
                completionHandler(nil, "failed")
            }
        }
    }
}
