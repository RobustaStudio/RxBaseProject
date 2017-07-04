//
//  BaseAPI.swift
//  Alamofire
//
//  Created by Ahmed Magdi on 6/7/17.
//

import Foundation
import Moya

public protocol BaseAPI: TargetType, AccessTokenAuthorizable {
    var stubbedStatusCode:Int {get}
    var headers:[String:String] {get}
}

extension BaseAPI {
    public var baseURL: URL {
        guard let url = URL(string: Config.shared.url) else {
            fatalError("Invalid BaseURL. Please check if the URL:'\(Config.shared.url)' is correct")
        }
        return url
    }
    
    public var headers:[String:String] {
        return defaultHeaders
    }
    
    public var defaultHeaders:[String:String] {
        return ["Content-Type":"application/json", "Accept":"application/json"]
    }
}


