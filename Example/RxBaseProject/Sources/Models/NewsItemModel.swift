//
//  NewsItemModel.swift
//  RxBaseProject
//
//  Created by Ahmed Mohamed Fareed on 4/26/17.
//  Copyright © 2017 CocoaPods. All rights reserved.
//

import Foundation
import ObjectMapper
import RxBaseProject


class NewsItemModel: BaseModel {
    
    var newsItemId:Int!
    var newsItemName:String!
    var newsItemNameEncoding:String!
    var newsItemDisplayName:String!
    var newsItemUpdates:Int?
    var newsItemImageURLString:String!
    var newsItemImageWidth:Int?
    var newsItemImageHeight:Int?
    
    override func mapping(map: Map) {
        super.mapping(map: map)
        
        newsItemId <- map["list_id"]
        newsItemName <- map["list_name"]
        newsItemNameEncoding <- map["list_name_encoded"]
        newsItemDisplayName <- map["display_name"]
        newsItemUpdates <- map["updated"]
        newsItemImageURLString <- map["list_image"]
        newsItemImageWidth <- map["list_image_width"]
        newsItemImageHeight <- map["list_image_height"]
        
    }
}
