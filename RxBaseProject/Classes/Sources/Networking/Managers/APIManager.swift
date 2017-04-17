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

protocol APIManagerType: BaseAPIManagerType {
    // Functions
        func isLoggedIn(bool:Bool)
    
    //MARK:- public variables
        var shouldForceLoggout:Driver<Bool> {get}
 
    // outputs
        var requestIsLoading:Driver<Bool> {get}
}

//MARK:-
//MARK:-
class APIManager: BaseAPIManager,  APIManagerType  {
    
    static var isValidSession:Bool {
        _ = UserModel.shared
        let userDefaults = UserDefaults.standard
        if userDefaults.bool(forKey: "minicash_user_is_logged_in") {
            if let session = TokenModel.shared, session.isValid {
                return true
            }
        }
        return false
    }
    static let shared:APIManagerType = APIManager()
    fileprivate static let provider:Networking = Networking.newDefaultNetworking()
    fileprivate let forceLogout = Variable<Bool>(false)
    internal var shouldForceLoggout = Driver<Bool>.empty()
    internal var dBag = DisposeBag()
    internal var requestIsLoading = Driver<Bool>.just(true)
    
    override init() {
        shouldForceLoggout = forceLogout.asDriver()
        super.init()
    }
    
    func isLoggedIn(bool:Bool) {
        let userDefaults = UserDefaults.standard
        if APIManager.isValidSession {
            if !bool && (TokenModel.shared != nil  && TokenModel.shared!.isValid ) {
                forceLogout.value = true
            }else {
                forceLogout.value = false
            }
        }
        userDefaults.set(bool, forKey: "minicash_user_is_logged_in")
    }
    
}
