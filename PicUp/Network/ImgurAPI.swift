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
    static func post(imageData: Data, imageType: String?, completionHandler: @escaping (_ url: String?, _ errorMessage: String?) -> Void) {
        Alamofire.upload(multipartFormData: { multipartFormData in
            multipartFormData.append(imageData, withName: "image")
        }, to: Constants.Imgur.url, method: .post, headers: ["Authorization": "Client-ID \(Constants.Imgur.clientId)"],
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
                let success = json["success"].boolValue
                if success {
                    if let url = json["data"]["link"].string {
                        completionHandler(url, nil)
                    }
                } else {
                    print("Upload to Imgur failed. \(json)")
                    completionHandler(nil, "failed")
                }
            } catch {
                print("Response is not a valid json.")
                completionHandler(nil, "failed")
            }
        }
    }
}
