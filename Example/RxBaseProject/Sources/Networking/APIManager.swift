//
//  self.swift
//  MiniCash
//
//  Created by Ahmed Mohamed Fareed on 2/13/17.
//  Copyright © 2017 Ahmed Mohamed Magdi. All rights reserved.
//

import Foundation

import RxSwift
import RxCocoa
import ObjectMapper
import Moya
import Moya_ObjectMapper
import RxBaseProject

//MARK:-
//MARK:-
class APIManager  {
    
    static let shared:APIManager = APIManager()
    fileprivate static var provider:Networking<SampleAPI> = Networking<SampleAPI>.default(allowExtensiveDebuging: true)
    
    //MARK:- General
    func getNews() -> Observable<NewsModel> {
        return APIManager.provider.request(.newsList()).mapObject(NewsModel.self)
    }
}
