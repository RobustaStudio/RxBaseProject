//
//  News.swift
//  RxBaseProject
//
//  Created by Ahmed Mohamed Fareed on 4/26/17.
//  Copyright © 2017 CocoaPods. All rights reserved.
//

import Foundation
import RxBaseProject
import ObjectMapper

class NewsModel: BaseModel {
    
    var requestStatus:String!
    var newsCopyright:String!
    var newsNumResults:Int!
    
    var bestSellersDate:String!
    var publishData:String!
    var publishDatDescrition:String!
    
    var lists:[NewsItemModel]?
    
    override func mapping(map: Map) {
        super.mapping(map: map)
        
        requestStatus <- map["status"]
        newsCopyright <- map["copyright"]
        newsNumResults <- map["num_results"]
        
        lists <-  map["results.lists"]
    }
}
