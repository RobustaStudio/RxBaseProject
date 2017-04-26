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
    fileprivate static let provider:Networking = Networking()
    fileprivate let forceLogout = Variable<Bool>(false)
    internal var shouldForceLoggout = Driver<Bool>.empty()
    internal var dBag = DisposeBag()
    internal var requestIsLoading = Driver<Bool>.just(true)
    
    
    //MARK:- General
    func appVersion() -> Observable<String?> {
        let nsObject = Bundle.main.infoDictionary!["CFBundleShortVersionString"] as! String
        return APIManager.provider.provider.request(.validateAppVersion(version: nsObject)).map { (response) -> String? in
            if !(200..<299 ~= response.statusCode) { return nil }
            //            let _data = try? JSONSerialization.jsonObject(with: response.data, options: JSONSerialization.ReadingOptions.allowFragments) as! String
            //
            //            if let ver = _data {
            //                if (ver as NSString).doubleValue  > (nsObject as NSString).doubleValue {
            //                    return ver
            //                }
            //            }
            
            return nil
        }
    }
}
