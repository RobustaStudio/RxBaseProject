//
//  ErrorModel.swift
//  MiniCash
//
//  Created by Ahmed Mohamed Fareed on 3/3/17.
//  Copyright © 2017 Ahmed Mohamed Magdi. All rights reserved.
//

import Foundation
import ObjectMapper


public class ErrorModel: BaseModel {
    public var error:String?
    public var errorDetails:String?
    
    public override func mapping(map: Map) {
        error <- map["error"]
        errorDetails <- map["error_description"]
    }
}
