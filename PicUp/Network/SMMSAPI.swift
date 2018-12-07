//
//  SMMSAPI.swift
//  PicUp
//
//  Created by Joy on 2018-12-05.
//  Copyright © 2018 Joy Zeng. All rights reserved.
//

import Foundation
import Alamofire
//import AlamofireSwiftyJSON
import AppKit

class SMMSAPI: NSObject {
    static func post(imagePath: String) {
        let imageURL = URL(fileURLWithPath: imagePath)
        let imageName = imageURL.lastPathComponent
        let imageType = imageURL.pathExtension
        let imageData = try? Data(contentsOf: imageURL)
        
        let parameters: [String : Any] = [
            "ssl": true,
            "format": "json"
            ]
    
        Alamofire.upload(multipartFormData: { multipartFormData in
                for (key, value) in parameters {
                    multipartFormData.append("\(value)".data(using: String.Encoding.utf8)!, withName: key as String)
                }
            
                if let data = imageData {
                    multipartFormData.append(data, withName: "smfile", fileName: imageName, mimeType: "image/\(imageType)")
                }
            }, to: Constants.SMMS.url,
               encodingCompletion: { encodingResult in
                switch encodingResult {
                case .success(let upload, _, _):
                    upload.responseJSON { response in
                        print(response)
//                        if let result = response.result.value {
//                            let json = result as! NSDictionary
//                            let code = json["code"] as! String
//                            if code == "success" {
//                                let url = json["data"]["url"]
//                                print(url)
//                            } else {
//                                print("error")
//                            }
//                        }
                        
                    }
                case .failure(let encodingError):
                    print("error:\(encodingError)")
                }
        })
    }
}
