//
//  BookModel.swift
//  RxBaseProject
//
//  Created by Ahmed Mohamed Fareed on 4/26/17.
//  Copyright © 2017 CocoaPods. All rights reserved.
//

import Foundation

import ObjectMapper
import RxBaseProject

class BookModel: BaseModel {
    
    
    var book_age_group:String?
    var book_amazon_product_url:String?
    var book_article_chapter_link:String?
    var book_author:String?
    var book_book_image:String?
    var book_book_image_width:String?
    var book_book_image_height:String?
    var book_book_review_link:String?
    var book_contributor:String?
    var book_contributor_note:String?
    var book_created_date:String?
    var book_description:String?
    var book_first_chapter_link:String?
    var book_price:String?
    var book_primary_isbn10:String?
    var book_primary_isbn13:String?
    var book_publisher:String?
    var book_rank:String?
    var book_rank_last_week:String?
    var book_sunday_review_link:String?
    var book_title:String?
    var book_updated_date:String?
    var book_weeks_on_list:String?
    
    override func mapping(map: Map) {
        super.mapping(map: map)
        
        
    }
}
