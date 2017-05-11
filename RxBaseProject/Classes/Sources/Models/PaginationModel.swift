//
//  PaginationModel.swift
//  MiniCash
//
//  Created by Ahmed Mohamed Fareed on 2/15/17.
//  Copyright © 2017 Ahmed Mohamed Magdi. All rights reserved.
//

import Foundation
import ObjectMapper

open class PaginationModel<Type:BaseModel>: BaseModel {
    
    var totalCount:Int?
    var perPage:Int?
    var currentPage:Int?
    var lastPage:Int?
    
    var nextPageUrl:String?
    var prevPageUrl:String?
    
    var fromId:Int?
    var toId:Int?
    
    var list:[Type]!
    
    open override func mapping(map: Map) {
        super.mapping(map: map)
        totalCount  <- map["total"]
        perPage     <- map["per_page"]
        currentPage <- map["current_page"]
        lastPage    <- map["total_pages"]
        nextPageUrl <- map["next_page_url"]
        prevPageUrl <- map["prev_page_url"]
        fromId      <- map["from"]
        toId        <- map["to"]
        list        <- map["data"]
    }
}
