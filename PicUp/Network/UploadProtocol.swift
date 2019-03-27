//
//  UploadProtocol.swift
//  PicUp
//
//  Created by Joy on 2019-02-16.
//  Copyright © 2019 Joy Zeng. All rights reserved.
//

import Foundation
import Alamofire

protocol UploadProtocol {
    static func post(imageData: Data, imageType: String?, completionHandler: @escaping (_ url: String?, _ errorMessage: String?) -> Void)
    
    static func parse(value: Data, completionHandler: (_ url: String?, _ errorMessage: String?) -> Void)
}
