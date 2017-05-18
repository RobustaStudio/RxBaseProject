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
    
    public var totalCount:Int?
    public var perPage:Int?
    public var currentPage:Int?
    public var lastPage:Int?
    
    public var nextPageUrl:String?
    public var prevPageUrl:String?
    
    public var fromId:Int?
    public var toId:Int?
    
    public var list:[Type]!
    
    open override func mapping(map: Map) {
        super.mapping(map: map)
        totalCount  <- map["total"]
        perPage     <- map["per_page"]
        currentPage <- map["current_page"]
        lastPage    <- map["last_page"]
        nextPageUrl <- map["next_page_url"]
        prevPageUrl <- map["prev_page_url"]
        fromId      <- map["from"]
        toId        <- map["to"]
        list        <- map["data"]
    }
}
