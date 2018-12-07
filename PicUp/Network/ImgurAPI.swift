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

    static func post(imagePath: String) {
    
    let imageData = try? Data(contentsOf: URL(fileURLWithPath: imagePath))
    let base64Image = imageData?.base64EncodedString(options: .lineLength64Characters)
        
    let parameters = [
        "image": base64Image
    ]
    
    Alamofire.upload(multipartFormData: { multipartFormData in
        for (key, value) in parameters {
            multipartFormData.append((value?.data(using: .utf8))!, withName: key)
        }}, to: Constants.Imgur.url, method: .post, headers: ["Authorization": "Client-ID \(Constants.Imgur.clientId)"],
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
                                        print(url)
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
