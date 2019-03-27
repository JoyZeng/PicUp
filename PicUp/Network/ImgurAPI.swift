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

// API doc: https://api.imgur.com/endpoints/image/
class ImgurAPI: NSObject, UploadProtocol {
    static func post(imageData: Data, imageType: String?, completionHandler: @escaping (_ url: String?, _ errorMessage: String?) -> Void) {
        AF.upload(
            multipartFormData: { multipartFormData in
                multipartFormData.append(imageData, withName: "image")
            },
            usingThreshold: 0,
            to: Constants.Imgur.url,
            method: .post,
            headers: ["Authorization": "Client-ID \(Constants.Imgur.clientId)"],
            interceptor: nil)
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
        let success = json["success"].boolValue
        if success {
            if let url = json["data"]["link"].string {
                completionHandler(url, nil)
            }
        } else {
            print("Upload to Imgur failed. \(json)")
            completionHandler(nil, "failed")
        }
    }
}
