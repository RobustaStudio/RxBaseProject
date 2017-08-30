//
//  PaginationModel.swift
//  MiniCash
//
//  Created by Ahmed Mohamed Fareed on 2/15/17.
//  Copyright © 2017 Ahmed Mohamed Magdi. All rights reserved.
//

import Foundation
import ObjectMapper


public class PaginationModelConfig {
    
    public var totalCount: String   = "total"
    public var perPage: String      = "per_page"
    public var currentPage: String  = "current_page"
    public var lastPage: String     = "last_page"
    public var nextPageUrl: String  = "next_page_url"
    public var prevPageUrl: String  = "prev_page_url"
    public var fromId: String       = "from"
    public var toId: String         = "to"
    public var list: String         = "data"
}

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
        let pg = Config.shared.paginationKeys!
        
        totalCount  <- map[pg.totalCount]
        perPage     <- map[pg.perPage]
        currentPage <- map[pg.currentPage]
        lastPage    <- map[pg.lastPage]
        nextPageUrl <- map[pg.nextPageUrl]
        prevPageUrl <- map[pg.prevPageUrl]
        fromId      <- map[pg.fromId]
        toId        <- map[pg.toId]
        list        <- map[pg.list]
    }
}
