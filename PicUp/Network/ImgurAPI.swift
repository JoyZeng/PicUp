//
//  ImgurAPI.swift
//  PicUp
//
//  Created by Joy on 2018-12-02.
//  Copyright © 2018 Joy Zeng. All rights reserved.
//

import Foundation
import Alamofire
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
                    upload.response { response in
                        let json = try? JSONSerialization.jsonObject(with: response.data!, options: .allowFragments) as! [String: Any]
                        print(json as Any)
                        let imageDic = json?["data"] as? [String:Any]
                        print(imageDic?["link"] as Any)
                    }
                case .failure(let encodingError):
                    print("error:\(encodingError)")
                }
        })
    }
}
