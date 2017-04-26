//
//  BaseAPIManager.swift
//  
//
//  Created by Ahmed Magdi on 3/22/17.
//  Copyright © 2017 Ahmed Mohamed Magdi. All rights reserved.
//

import Foundation

import RxSwift
import RxCocoa
import ObjectMapper
import Moya
import Moya_ObjectMapper


protocol BaseAPIManagerType {
    associatedtype T: TargetType, AccessTokenAuthorizable
    // outputs
    var requestIsLoading:Driver<Bool> {get}
}
//
////MARK:-
////MARK:-
//class BaseAPIManager: BaseAPIManagerType  {
//    
//    public static let shared:BaseAPIManagerType = BaseAPIManager()
//    fileprivate static var provider:Networking<T>!
//    internal var dBag = DisposeBag()
//    internal var requestIsLoading = Driver<Bool>.just(true)
//    
//    init() {
//        
//    }
//    
//    
//    
//}
//
