//
//  ErrorModel.swift
//  MiniCash
//
//  Created by Ahmed Mohamed Fareed on 3/3/17.
//  Copyright © 2017 Ahmed Mohamed Magdi. All rights reserved.
//

import Foundation
import ObjectMapper


class ErrorModel: BaseModel {
    
    var error:String?
    var errorDetails:String?
    
    override func mapping(map: Map) {
        error <- map["error"]
        errorDetails <- map["error_description"]
    }
    
    
}
