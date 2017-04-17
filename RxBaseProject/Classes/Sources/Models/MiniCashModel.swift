//
//  MiniCashModel.swift
//  MiniCash
//
//  Created by Ahmed Mohamed Fareed on 2/18/17.
//  Copyright © 2017 Ahmed Mohamed Magdi. All rights reserved.
//

import UIKit
import ObjectMapper

let MINICASH_DATE_FORMAT_0 = "YYYY-MM-dd HH:mm:ss"
let MINICASH_DATE_FORMAT_1 = "YYYY-MM-dd HH:mm:ss.S"
class MiniCashModel: BaseModel {
    
    var createdAt:Date?
    var updatedAt:Date?
    var createdAtString:String?
    
    override func mapping(map: Map) {
        super.mapping(map: map)
        createdAtString <- map["created_at"]
        createdAt <- (map["created_at"],CustomDateFormatTransform(formatString: MINICASH_DATE_FORMAT_0))
        updatedAt <- (map["updated_at"],CustomDateFormatTransform(formatString: MINICASH_DATE_FORMAT_0))
    }
}
