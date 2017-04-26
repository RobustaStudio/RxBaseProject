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
    
    override func mapping(map: Map) {
        super.mapping(map: map)
        
        requestStatus <- map["status"]
        newsCopyright <- map["copyright"]
        newsNumResults <- map["num_results"]
    }
}
